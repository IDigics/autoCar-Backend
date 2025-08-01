import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HttpModule } from '@nestjs/axios';

import { Recommendation} from './recommendation.entity';
import { RecommendationService } from './recommendation.service';
import { RecommendationController } from './recommendation.controller';
import { Car } from 'src/car/car.entity';
import { RecommendedCar } from 'src/recommended-car/recommended-car.entity';


@Module({
  imports: [HttpModule, TypeOrmModule.forFeature([Car, Recommendation, RecommendedCar])],
  providers: [RecommendationService],
  controllers: [RecommendationController],
  exports: [RecommendationService],
})
export class RecommendationModule {}