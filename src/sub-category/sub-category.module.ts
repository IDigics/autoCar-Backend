import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SubCategory } from './sub-category.entity';

@Module({
  imports: [TypeOrmModule.forFeature([SubCategory])],
  providers: [],
  controllers: [],
})
export class SubCategoryModule {}
