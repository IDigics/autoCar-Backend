import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Review } from './review.entity';
import { ReviewService } from './review.service';
import { ReviewController } from './review.controller';
import { Car } from 'src/car/car.entity';

@Module({
imports: [
    TypeOrmModule.forFeature([Review, Car]), 
  ],
  providers: [ReviewService],
  controllers: [ReviewController],
})
export class ReviewModule {}
