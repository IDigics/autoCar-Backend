import { Injectable, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Between, LessThanOrEqual, MoreThanOrEqual, Repository } from 'typeorm';
import { Car } from './car.entity';
import { Brand } from '../brand/brand.entity';
import { Category } from '../category/category.entity';
import { SubCategory } from '../sub-category/sub-category.entity';
import { FuelType } from '../fuel-type/fuel-type.entity';
import { CarImage } from '../car-image/car-image.entity';
import { CarImageService } from '../car-image/car-image.service';

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


  private buildWhere(filters: Record<string, any>) {
  const where: Record<string, any> = {};

  if (filters.brand !== undefined) where.brand = { id: filters.brand };
  if (filters.category !== undefined) where.category = { id: filters.category };
  if (filters.subCategory !== undefined) where.subCategory = { id: filters.subCategory };
  if (filters.fuelType !== undefined) where.fuelType = { id: filters.fuelType };

  if (filters.minPrice !== undefined && filters.maxPrice !== undefined) {
    // Corrected here:
    where.price = Between(filters.minPrice, filters.maxPrice);
  } else if (filters.minPrice !== undefined) {
    where.price = MoreThanOrEqual(filters.minPrice);
  } else if (filters.maxPrice !== undefined) {
    where.price = LessThanOrEqual(filters.maxPrice);
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

async createCar(
    carDto: any,
    mainImage: Express.Multer.File,
    secondaryImages: Express.Multer.File[],
  ): Promise<Car> {
    // 1. Create or get Brand
    let brand = await this.brandRepo.findOneBy({ name: carDto.brand });
    if (!brand) {
      brand = this.brandRepo.create({ name: carDto.brand });
      await this.brandRepo.save(brand);
    }

    // 2. get Category
    let category = await this.categoryRepo.findOneBy({ name: carDto.category });
    if (!category)throw new BadRequestException ('Invalid category');

    // 3. get SubCategory
    let subCategory = await this.subCategoryRepo.findOneBy({ name: carDto.subCategory });
    if (!subCategory) throw new BadRequestException ('Invalid sub-category');

    // 4. Get Fuel Type
    const fuelType = await this.fuelRepo.findOneBy({ type: carDto.fuelType });
    if (!fuelType) throw new BadRequestException('Invalid fuel type');

    // 5. Handle offerType logic
    const isNew = carDto.offerType.toLowerCase() === 'new';

    const mileage = isNew ? 0 : parseInt(carDto.mileage);
    const previousOwner = isNew ? 0 : parseInt(carDto.previousOwner);

    // 6. Handle image upload
    const imageEntities: CarImage[] = [];

    // a. Main image
    if (mainImage) {
      const filename = await this.imageService.processAndSaveImage(mainImage);
      imageEntities.push(
        this.imageRepo.create({
          url: filename,
          type: 'main',
        }),
      );
    }

    // b. Secondary images
    if (secondaryImages && secondaryImages.length > 0) {
      const filenames = await this.imageService.processAndSaveImages(secondaryImages);
      filenames.forEach((name) => {
        imageEntities.push(
          this.imageRepo.create({
            url: name,
            type: 'secondary',
          }),
        );
      });
    }

    // 7. Create the car
    const car = this.carRepo.create({
      mileage,
      previousOwner,
      brand,
      model: carDto.model,
      fuelType,
      gear: carDto.gear,
      offerType: carDto.offerType,
      price: parseInt(carDto.price),
      horsePower: parseInt(carDto.horsePower),
      year: parseInt(carDto.year),
      engineSize: parseFloat(carDto.engineSize),
      doors: parseInt(carDto.doors),
      seats: parseInt(carDto.seats),
      color: carDto.color,
      category,
      subCategory,
      images: imageEntities,
    });

    return await this.carRepo.save(car);
  } 

  async updateCar(id: number, updateDto: any) {
    await this.carRepo.update(id, updateDto);
    return this.carRepo.findOneBy({ id });
  }

  async deleteCar(id: number) {
    return this.carRepo.delete(id);
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
}
