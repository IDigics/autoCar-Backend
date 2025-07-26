import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Between, ILike, In, LessThanOrEqual, MoreThanOrEqual, Repository } from 'typeorm';
import * as path from 'path';
import * as fs from 'fs/promises';

import { Car } from './car.entity';
import { Brand } from '../brand/brand.entity';
import { Category } from '../category/category.entity';
import { SubCategory } from '../sub-category/sub-category.entity';
import { FuelType } from '../fuel-type/fuel-type.entity';
import { CarImage } from '../car-image/car-image.entity';

import { CarImageService } from '../car-image/car-image.service';

import { CreateCarDto } from './dto/create-car.dto';
import { UpdateCarDto } from './dto/update-car.dto';

@Injectable()
export class CarService {
  constructor(
    @InjectRepository(Car) private carRepo: Repository<Car>,
    @InjectRepository(Brand) private brandRepo: Repository<Brand>,
    @InjectRepository(Category) private categoryRepo: Repository<Category>,
    @InjectRepository(SubCategory) private subCategoryRepo: Repository<SubCategory>,
    @InjectRepository(FuelType) private fuelRepo: Repository<FuelType>,
    @InjectRepository(CarImage) private imageRepo: Repository<CarImage>,
    private imageService: CarImageService,
  ) {}

  async getCars(filters: Record<string, any>,sort: string,page: number,pageSize = 10,) {
        
    if (isNaN(page) || page < 1) {
          throw new BadRequestException('Page must be a positive number.');
        }

    if (isNaN(pageSize) || pageSize < 1 || pageSize > 100) {
          throw new BadRequestException('Page size must be between 1 and 100.');
        }

    let where, order;

    try {
          where = this.buildWhere(filters);
          order = this.buildSort(sort);
    } catch (err) {
          throw new BadRequestException(err.message || 'Invalid filter or sort');
        }

    const [cars, totalCount] = await this.carRepo.findAndCount({
          where,
          order,
          take: pageSize,
          skip: (page - 1) * pageSize,
          relations: ['brand', 'fuelType', 'images'],
    });

    const simplifiedCars = cars.map((car) => {
          const mainImage = car.images.find((img) => img.type === 'main');

      return {
            id: car.id,
            brand: car.brand?.name,
            model: car.model,
            fuelType: car.fuelType?.type,
            offerType: car.offerType,
            price: car.price,
            year: car.year,
            color: car.color,
            rating: car.averageReviewScore,
            image: mainImage?.url || null,
      };
    });

    return {
          cars: simplifiedCars,
          metadata: {
            totalCount,
            page,
            pageSize,
          },
    };
  }

  async getCarById(id: number) {
  const car = await this.carRepo.findOne({
    where: { id },
    relations: ['brand', 'category', 'subCategory', 'fuelType', 'images'],
  });

  if (!car) {
    throw new NotFoundException(`Car with ID ${id} not found`);
  }

  const { images, ...carWithoutImages } = car;
  const [mainImage, ...secondaryImages] = images;

  return {
    ...carWithoutImages,
    mainImage,
    secondaryImages,
  };
  }

  async createCar(carDto: CreateCarDto,mainImage?: Express.Multer.File,secondaryImages?: Express.Multer.File[]) {
    const { brand, category, subCategory, fuelType } = await this.validateRelations(carDto);

    const { mileage, previousOwner } = this.getMileageAndPreviousOwner(
      carDto.offerType,
      carDto.mileage,
      carDto.previousOwner,
    );

    if (!mainImage) {
      throw new BadRequestException('Main image is required');
    }
    const mainImageName = await this.imageService.processAndSaveImage(mainImage);

    const imageEntities: CarImage[] = [
      this.imageRepo.create({ url: mainImageName, type: 'main' }),
    ];

    if (secondaryImages && secondaryImages.length > 0) {
      const secondaryFilenames = await this.imageService.processAndSaveImages(secondaryImages);
      secondaryFilenames.forEach(filename => {
        imageEntities.push(this.imageRepo.create({ url: filename, type: 'secondary' }));
      });
    }

    const car = this.carRepo.create({
      brand,
      category,
      subCategory,
      fuelType,
      mileage,
      previousOwner,
      model: carDto.model,
      gear: carDto.gear,
      offerType: carDto.offerType,
      price: carDto.price,
      horsePower: carDto.horsePower,
      year: carDto.year,
      engineSize: carDto.engineSize,
      doors: carDto.doors,
      seats: carDto.seats,
      color: carDto.color,
      images: imageEntities,
    });

  await this.carRepo.save(car);
  }

  async updateCar(id: number,dto: UpdateCarDto,mainImageFile?: Express.Multer.File,secondaryImageFiles?: Express.Multer.File[],) {
      const car = await this.carRepo.findOne({
        where: { id },
        relations: ['images'],
      });
      if (!car) throw new NotFoundException('Car not found');

      // Update simple fields
      Object.assign(car, dto);

      // Update relations
      if (dto.brandId) car.brand = { id: dto.brandId } as any;
      if (dto.fuelTypeId) car.fuelType = { id: dto.fuelTypeId } as any;
      if (dto.categoryId) car.category = { id: dto.categoryId } as any;
      if (dto.subCategoryId) car.subCategory = { id: dto.subCategoryId } as any;

      // ✅ Save the car first to ensure valid reference for images
      await this.carRepo.save(car);

      // Delete specified secondary images
      if (dto.deletedImageIds?.length) {
        await this.imageRepo.delete({
          id: In(dto.deletedImageIds),
          car: { id },
          type: 'secondary',
        });
      }

      // Add new secondary images
      if (secondaryImageFiles?.length) {
        for (const file of secondaryImageFiles) {
          const url = await this.imageService.processAndSaveImage(file);
          const newImg = this.imageRepo.create({
            url,
            type: 'secondary',
            car, // or: car: { id: car.id } as any
          });
          await this.imageRepo.save(newImg);
        }
      }

      // Replace main image
      if (mainImageFile) {
        const currentMain = car.images.find(img => img.type === 'main');
        if (currentMain) {
          await this.imageRepo.remove(currentMain);
        }
        const mainUrl = await this.imageService.processAndSaveImage(mainImageFile);
        const newMain = this.imageRepo.create({
          url: mainUrl,
          type: 'main',
          car,
        });
        await this.imageRepo.save(newMain);
      }

      return {message: 'Car updated successfully'};
}


  async deleteCar(id: number): Promise<void> {
      const car = await this.carRepo.findOne({
        where: { id },
        relations: ['images'],
      });

      if (!car) throw new NotFoundException('Car not found');

      // Delete image files from disk
      for (const image of car.images) {
        const filePath = path.join(this.imageService.uploadFolder, image.url);
        await fs.unlink(filePath).catch(() => null); // ignore error if file missing
      }

      // Delete images from DB
      await this.imageRepo.delete({ car: { id } });

      // Delete the car itself
      await this.carRepo.delete(id);
  }

  private buildWhere(filters: Record<string, any>) {
    const allowedFilters = [
      'brand', 'category', 'subCategory', 'fuelType', 
      'minPrice', 'maxPrice', 'search'
    ];
    for (const key of Object.keys(filters)) {
      if (!allowedFilters.includes(key)) {
        throw new BadRequestException(`Unknown filter: '${key}'`);
      }
    }
    const where: Record<string, any> = {};
    const isValidId = (val: any) => !isNaN(val) && Number(val) > 0;

    if (isValidId(filters.brand)) where.brand = { id: filters.brand };
    if (isValidId(filters.category)) where.category = { id: filters.category };
    if (isValidId(filters.subCategory)) where.subCategory = { id: filters.subCategory };
    if (isValidId(filters.fuelType)) where.fuelType = { id: filters.fuelType };

    if (filters.minPrice !== undefined && filters.maxPrice !== undefined) {
      where.price = Between(Number(filters.minPrice), Number(filters.maxPrice));
    } else if (filters.minPrice !== undefined) {
      where.price = MoreThanOrEqual(Number(filters.minPrice));
    } else if (filters.maxPrice !== undefined) {
      where.price = LessThanOrEqual(Number(filters.maxPrice));
    }

    if (filters.search) {
      const search = `%${filters.search}%`;

      try {
        return [
          { ...where, model: ILike(search) },
          { ...where, brand: { ...where.brand, name: ILike(search) } },
          { ...where, category: { ...where.category, name: ILike(search) } },
        ];
      } catch (err) {
        throw new Error('Invalid search parameters');
      }
    }

    return where;
  }

  private buildSort(sort: string): { [P in keyof Car]?: 'ASC' | 'DESC' } {
    const validSorts = [
      'price_asc', 'price_desc',
      'year_asc', 'year_desc',
      'review_asc', 'review_desc',
    ];

    if (!sort || !validSorts.includes(sort)) {
      return { id: 'ASC' }; // default fallback
    }

    switch (sort) {
      case 'price_asc':
        return { price: 'ASC' };
      case 'price_desc':
        return { price: 'DESC' };
      case 'year_asc':
        return { year: 'ASC' };
      case 'year_desc':
        return { year: 'DESC' };
      case 'review_asc':
        return { averageReviewScore: 'ASC' };
      case 'review_desc':
        return { averageReviewScore: 'DESC' };
      default:
        throw new Error('Invalid sort value');
    }
  }

  async getMinMaxPrice(): Promise<{ minPrice: number; maxPrice: number }> {
    const min = await this.carRepo
      .createQueryBuilder('car')
      .select('MIN(car.price)', 'min')
      .getRawOne();

    const max = await this.carRepo
      .createQueryBuilder('car')
      .select('MAX(car.price)', 'max')
      .getRawOne();

    return {
      minPrice: parseInt(min.min),
      maxPrice: parseInt(max.max),
    };
  }

  async validateRelations(carDto: CreateCarDto) {
    const brand = await this.brandRepo.findOneBy({ id: carDto.brandId });
    if (!brand) throw new BadRequestException('Invalid brand');

    const category = await this.categoryRepo.findOneBy({ id: carDto.categoryId });
    if (!category) throw new BadRequestException('Invalid category');

    const subCategory = await this.subCategoryRepo.findOneBy({ id: carDto.subCategoryId });
    if (!subCategory) throw new BadRequestException('Invalid sub-category');

    const fuelType = await this.fuelRepo.findOneBy({ id: carDto.fuelTypeId });
    if (!fuelType) throw new BadRequestException('Invalid fuel type');
  return { brand, category, subCategory, fuelType };
}

  getMileageAndPreviousOwner(offerType: string, mileage?: number, previousOwner?: number) {
    const isNew = offerType.toLowerCase() === 'new';
    return {
      mileage: isNew ? 0 : mileage ?? 0,
      previousOwner: isNew ? 0 : previousOwner ?? 0,
    };
  }

}
