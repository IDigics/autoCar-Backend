import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Review } from './review.entity';
import { Repository } from 'typeorm';
import { CreateReviewDto } from './dto/review.dto';
import { Car } from '../car/car.entity';
import { CarService } from 'src/car/car.service';

@Injectable()
export class ReviewService {
  constructor(
    @InjectRepository(Review) private reviewRepo: Repository<Review>,
    @InjectRepository(Car) private carRepo: Repository<Car>,
    private readonly carService: CarService,
  ) {}


    async createReview(carId: number, createReviewDto: CreateReviewDto): Promise<{ message: string }> {
    const car = await this.carRepo.findOne({ where: { id: carId } });
    if (!car) {
        throw new NotFoundException(`Car with id ${carId} not found`);
    }
    const existingReview = await this.reviewRepo.findOne({
        where: { car: { id: carId }, email: createReviewDto.email },
    });
    if (existingReview) {
        throw new BadRequestException('You have already reviewed this car.');
    }
    const review = this.reviewRepo.create({
        car,
        email: createReviewDto.email,
        score: createReviewDto.score,
        comment: createReviewDto.comment,
    });
    await this.reviewRepo.save(review);
    await this.carService.updateAverageScore(carId);
    return { message: 'Review created successfully' };
    }


    
  async getReviewsByCarId(carId: number, limit: number): Promise<Review[]> {
    const car = await this.carRepo.findOne({ where: { id: carId } });
    if (!car) {
      throw new NotFoundException(`Car with id ${carId} not found`);
    }

    return this.reviewRepo.find({
      where: { car: { id: carId } },
      take: limit,
      order: { id: 'DESC' },
    });
  }
}
