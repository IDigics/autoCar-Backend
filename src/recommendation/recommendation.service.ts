import {
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
  Logger,
} from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { ConfigService } from '@nestjs/config';

import { Car } from '../car/car.entity';
import { Recommendation } from './recommendation.entity';
import { RecommendedCar } from '../recommended-car/recommended-car.entity';

@Injectable()
export class RecommendationService {
  private readonly logger = new Logger(RecommendationService.name);
  private readonly apiBase: string;

  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
    @InjectRepository(Car) private readonly carRepo: Repository<Car>,
    @InjectRepository(Recommendation) private readonly recommendationRepo: Repository<Recommendation>,
    @InjectRepository(RecommendedCar) private readonly recommendedCarRepo: Repository<RecommendedCar>,
  ) {
    const apiBase = this.configService.get<string>('RECOMMENDATION_API_BASE');
    if (!apiBase) {
      throw new Error('RECOMMENDATION_API_BASE is not defined in the environment.');
    }
    this.apiBase = apiBase;
  }

  async getRecommendationsForCar(carId: number, n = 3): Promise<any[]> {
    this.logger.log(`Requesting ${n} recommendations for car ID ${carId}`);

    const existing = await this.recommendationRepo.findOne({
      where: { car: { id: carId } },
      relations: [
        'recommendedCars',
        'recommendedCars.car',
        'recommendedCars.car.brand',
        'recommendedCars.car.fuelType',
        'recommendedCars.car.images',
      ],
    });

    if (existing) {
      const cachedCount = existing.recommendedCars.length;
      this.logger.log(`Found ${cachedCount} recommendations in DB for car ID ${carId}`);

      if (cachedCount >= n) {
        this.logger.log(`Serving first ${n} cached recommendations`);
        const cars = existing.recommendedCars.slice(0, n).map(rc => rc.car);
        return this.serializeCars(cars);
      }

      this.logger.warn(`Cached (${cachedCount}) < requested (${n}) → deleting old cache`);
      await this.recommendationRepo.delete(existing.id);
    } else {
      this.logger.log(`No cached recommendations found for car ID ${carId}`);
    }

    this.logger.log(`Calling external API: ${this.apiBase}/recommend with car_id=${carId} and n=${n}`);

    try {
      const response = await firstValueFrom(
        this.httpService.post(`${this.apiBase}/recommend`, { car_id: carId, n }),
      );

      const recommendedIds: number[] = response.data;
      this.logger.log(`API returned IDs: [${recommendedIds.join(', ')}]`);

      const cars = await this.carRepo.find({
        where: { id: In(recommendedIds) },
        relations: ['brand', 'fuelType', 'images'],
      });

      this.logger.log(`Fetched ${cars.length} recommended cars from DB`);

      const recommendation = this.recommendationRepo.create({
        car: { id: carId },
        date: new Date(),
        recommendedCars: cars.map(car => this.recommendedCarRepo.create({ car })),
      });

      await this.recommendationRepo.save(recommendation);
      this.logger.log(`Saved new recommendations for car ID ${carId}`);

      return this.serializeCars(cars);
    } catch (err) {
      if (err.response?.data?.detail?.includes('not found')) {
        this.logger.error(`Car ID ${carId} not found in external API`);
        throw new NotFoundException(`Car ID ${carId} not found in external recommendation API`);
      }

      // Clean log: only error message, no stack trace
      this.logger.error('Failed to fetch recommendations from external API: ' + (err.message || err));

      // Throw 503 Service Unavailable with clean message (no stack trace sent to client)
      throw new ServiceUnavailableException('Failed to fetch recommendations');
    }
  }

  private serializeCars(cars: Car[]): any[] {
    return cars.map(car => {
      const mainImage = car.images.find(img => img.type === 'main');
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
  }

  async clearAllRecommendations() {
  await this.recommendationRepo.manager.query(
    'TRUNCATE TABLE recommended_car, recommendation CASCADE',
  );
  this.logger.warn('All recommendations cleared from the database (cascade)');
}
  
}
