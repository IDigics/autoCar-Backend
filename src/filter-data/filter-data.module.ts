import { Module } from '@nestjs/common';
import { FilterDataService } from './filter-data.service';
import { FilterDataController } from './filter-data.controller';
import { BrandModule } from '../brand/brand.module';
import { CategoryModule } from '../category/category.module';
import { SubCategoryModule } from '../sub-category/sub-category.module';
import { FuelTypeModule } from '../fuel-type/fuel-type.module';
import { CarModule } from 'src/car/car.module';

@Module({
  imports: [BrandModule, CategoryModule, SubCategoryModule, FuelTypeModule,CarModule],
  controllers: [FilterDataController],
  providers: [FilterDataService],
})
export class FilterDataModule {}