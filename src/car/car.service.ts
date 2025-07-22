import { Injectable, Logger } from '@nestjs/common';
import { Repository, MoreThanOrEqual, LessThanOrEqual } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Car } from './car.entity';

@Injectable()
export class CarService {
  private readonly logger = new Logger(CarService.name);

  constructor(
    @InjectRepository(Car)
    private carRepo: Repository<Car>,
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
      relations: ['images'],
    });

    return {
      cars,
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
      // Add range support
      where.price = {
        ...(filters.minPrice !== undefined && { $gte: filters.minPrice }),
        ...(filters.maxPrice !== undefined && { $lte: filters.maxPrice }),
      };
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
      case 'review_score_asc':
        return { averageReviewScore: 'ASC' };
      case 'review_score_desc':
        return { averageReviewScore: 'DESC' };
      default:
        return { id: 'ASC' };
    }
  }

  async createCar(carDto: any) {
    return this.carRepo.save(carDto);
  }

  async updateCar(id: number, updateDto: any) {
    await this.carRepo.update(id, updateDto);
    return this.carRepo.findOneBy({ id });
  }

  async deleteCar(id: number) {
    return this.carRepo.delete(id);
  }
}
