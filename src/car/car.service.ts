import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Between, ILike, LessThanOrEqual, MoreThanOrEqual, Repository } from 'typeorm';

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
  updateCar(id: string, updateCarDto: UpdateCarDto, arg2: Express.Multer.File | undefined, secondaryImages: Express.Multer.File[] | undefined) {
    throw new Error('Method not implemented.');
  }
  carImageService: any;
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
  // 1. Validate existing relations
  const brand = await this.brandRepo.findOneBy({ name: carDto.brand });
  if (!brand) throw new BadRequestException('Invalid brand');

  const category = await this.categoryRepo.findOneBy({ name: carDto.category });
  if (!category) throw new BadRequestException('Invalid category');

  const subCategory = await this.subCategoryRepo.findOneBy({ name: carDto.subCategory });
  if (!subCategory) throw new BadRequestException('Invalid sub-category');

  const fuelType = await this.fuelRepo.findOneBy({ type: carDto.fuelType });
  if (!fuelType) throw new BadRequestException('Invalid fuel type');

  // 2. Handle offerType logic
  const isNew = carDto.offerType.toLowerCase() === 'new';
  const mileage = isNew ? 0 : carDto.mileage ?? 0;
  const previousOwner = isNew ? 0 : carDto.previousOwner ?? 0;

  // 3. Handle image upload or default image
  const mainImageName = mainImage
    ? await this.carImageService.processAndSaveImage(mainImage)
    : 'noimage.webp';

  const imageEntities: CarImage[] = [];

  // Add main image entity
  imageEntities.push(
    this.imageRepo.create({
      url: mainImageName,
      type: 'main',
    }),
  );

  // Add secondary images if any
  if (secondaryImages && secondaryImages.length > 0) {
    const secondaryFilenames = await this.carImageService.processAndSaveImages(secondaryImages);
    secondaryFilenames.forEach((filename) => {
      imageEntities.push(
        this.imageRepo.create({
          url: filename,
          type: 'secondary',
        }),
      );
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
