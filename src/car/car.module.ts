import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from './car.entity';
import { CarService } from './car.service';
import { CarController } from './car.controller';
import { Category } from 'src/category/category.entity';
import { SubCategory } from 'src/sub-category/sub-category.entity';
import { FuelType } from 'src/fuel-type/fuel-type.entity';
import { CarImage } from 'src/car-image/car-image.entity';
import { Review } from 'src/review/review.entity';
import { Brand } from 'src/brand/brand.entity';
import { CarImageService } from 'src/car-image/car-image.service';


@Module({
imports: [TypeOrmModule.forFeature([Car,Category,SubCategory,FuelType,CarImage,Brand,Review,])],
  providers: [CarService,CarImageService],
  controllers: [CarController],
  exports: [CarService],
})
export class CarModule {}