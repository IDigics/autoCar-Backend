import { Module } from '@nestjs/common';
import { ImportService } from './import.service';
import { ImportController } from './import.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from 'src/car/car.entity';
import { Brand } from 'src/brand/brand.entity';
import { Category } from 'src/category/category.entity';
import { SubCategory } from 'src/sub-category/sub-category.entity';
import { FuelType } from 'src/fuel-type/fuel-type.entity';
import { CarImage } from 'src/car-image/car-image.entity';
import { CarImageModule } from 'src/car-image/car-image.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Car,
      Brand,
      Category,
      SubCategory,
      FuelType,
    ]),CarImageModule,
  ],
  providers: [ImportService],
  controllers: [ImportController]
})
export class ImportModule {}
