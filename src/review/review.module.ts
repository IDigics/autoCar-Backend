import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Review } from './review.entity';
import { ReviewService } from './review.service';
import { ReviewController } from './review.controller';
import { Car } from 'src/car/car.entity';
import { CarModule } from 'src/car/car.module';

@Module({
imports: [
    TypeOrmModule.forFeature([Review, Car]),CarModule
  ],
  providers: [ReviewService],
  controllers: [ReviewController],
  exports: [TypeOrmModule],
})
export class ReviewModule {}
