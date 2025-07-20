import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import {RecommendedCar } from './recommended-car.entity';

@Module({
  imports: [TypeOrmModule.forFeature([RecommendedCar])],
  providers: [],
  controllers: [],
})
export class RecommendedCarModule {}
