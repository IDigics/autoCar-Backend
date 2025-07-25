import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Between, ILike, In, LessThanOrEqual, MoreThanOrEqual, Repository } from 'typeorm';

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

  async getCars(
  filters: Record<string, any>,
  sort: string,
  page: number,
  pageSize = 10,
) {
  const [cars, totalCount] = await this.carRepo.findAndCount({
    where: this.buildWhere(filters),
    order: this.buildSort(sort),
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

  async createCar(
    carDto: CreateCarDto,
    mainImage?: Express.Multer.File,
    secondaryImages?: Express.Multer.File[],
  ): Promise<Car> {
    const { brand, category, subCategory, fuelType } = await this.validateRelations(carDto);

    const { mileage, previousOwner } = this.getMileageAndPreviousOwner(
      carDto.offerType,
      carDto.mileage,
      carDto.previousOwner,
    );

    const mainImageName = mainImage
      ? await this.imageService.processAndSaveImage(mainImage)
      : 'noimage.webp';

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

  return this.carRepo.save(car);
  }

 // car.service.ts
  async updateCar(id: number, dto: UpdateCarDto, mainImageFile?: Express.Multer.File, secondaryImageFiles?: Express.Multer.File[]) {
    const car = await this.carRepo.findOne({
      where: { id },
      relations: ['images'],
    });
    if (!car) throw new NotFoundException('Car not found');

    // --- 1. Update basic fields from dto
    Object.assign(car, dto);

    // --- 2. Update related FKs
    if (dto.brandId) car.brand = { id: dto.brandId } as any;
    if (dto.fuelTypeId) car.fuelType = { id: dto.fuelTypeId } as any;
    if (dto.categoryId) car.category = { id: dto.categoryId } as any;
    if (dto.subCategoryId) car.subCategory = { id: dto.subCategoryId } as any;

    // --- 3. Handle deleting secondary images
    if (dto.deletedImageIds?.length) {
      await this.imageRepo.delete({
        id: In(dto.deletedImageIds),
        car: { id },
        type: 'secondary',
      });
    }

    // --- 4. Upload secondary images
    if (secondaryImageFiles?.length) {
      for (const file of secondaryImageFiles) {
        const url = await this.imageService.processAndSaveImage(file);
        const newImg = this.imageRepo.create({ url, type: 'secondary', car });
        await this.imageRepo.save(newImg);
      }
    }

    // --- 5. Promote image to main (optional)
    if (dto.promotedImageId) {
      const imageToPromote = car.images.find((img) => img.id === dto.promotedImageId);
      if (imageToPromote) {
        // Demote old main if exists
        const currentMain = car.images.find((img) => img.type === 'main');
        if (currentMain) {
          if (dto.removeMainImage ?? true) {
            await this.imageRepo.remove(currentMain);
          } else {
            currentMain.type = 'secondary';
            await this.imageRepo.save(currentMain);
          }
        }
        // Promote new one
        imageToPromote.type = 'main';
        await this.imageRepo.save(imageToPromote);
      }
    }

    // --- 6. Upload new main image (optional)
    if (mainImageFile) {
      const currentMain = car.images.find((img) => img.type === 'main');
      if (currentMain) {
        if (dto.removeMainImage ?? true) {
          await this.imageRepo.remove(currentMain);
        } else {
          currentMain.type = 'secondary';
          await this.imageRepo.save(currentMain);
        }
      }
      const mainUrl = await this.imageService.processAndSaveImage(mainImageFile);
      const newMain = this.imageRepo.create({ url: mainUrl, type: 'main', car });
      await this.imageRepo.save(newMain);
    }

    // --- 7. Delete main image directly (with fallback logic)
    if (dto.removeMainImage && !mainImageFile && !dto.promotedImageId) {
      const currentMain = car.images.find((img) => img.type === 'main');
      if (currentMain && !currentMain.url.includes('noimage.webp')) {
        await this.imageRepo.remove(currentMain);

        // Fallback logic
        const updatedCarImages = await this.imageRepo.find({
          where: { car: { id }, type: 'secondary' },
          order: { id: 'ASC' },
        });

        let fallbackUrl = 'noimage.webp';
        if (updatedCarImages.length) {
          const fallbackImg = updatedCarImages[0];
          fallbackImg.type = 'main';
          await this.imageRepo.save(fallbackImg);
          fallbackUrl = fallbackImg.url;
        } else {
          const defaultImg = this.imageRepo.create({
            url: 'noimage.webp',
            type: 'main',
            car,
          });
          await this.imageRepo.save(defaultImg);
        }
      }
    }

    // --- 8. Save updated car
    return await this.carRepo.save(car);
  }

  async deleteCar(id: number) {
    return this.carRepo.delete(id);
  }

  private buildWhere(filters: Record<string, any>) {
    const where: Record<string, any> = {};

    if (filters.brand !== undefined) where.brand = { id: filters.brand };
    if (filters.category !== undefined) where.category = { id: filters.category };
    if (filters.subCategory !== undefined) where.subCategory = { id: filters.subCategory };
    if (filters.fuelType !== undefined) where.fuelType = { id: filters.fuelType };
    
    if (filters.minPrice !== undefined && filters.maxPrice !== undefined) {
      where.price = Between(filters.minPrice, filters.maxPrice);
    } else if (filters.minPrice !== undefined) {
      where.price = MoreThanOrEqual(filters.minPrice);
    } else if (filters.maxPrice !== undefined) {
      where.price = LessThanOrEqual(filters.maxPrice);
    }

    if (filters.search) {
      const search = `%${filters.search}%`;

      return [
        { ...where, model: ILike(search) },
        { ...where, brand: { ...where.brand, name: ILike(search) } },
        { ...where, category: { ...where.category, name: ILike(search) } },
      ];
    }

    return where;
  }

  private buildSort(sort: string): { [P in keyof Car]?: 'ASC' | 'DESC' } {
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
        return { id: 'ASC' };
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
