import { IsOptional, IsNumber, Min, Max, IsIn } from 'class-validator';
import { Type } from 'class-transformer';

export class CarFilterDto {
  @IsOptional()@Type(() => Number)@IsNumber()brand?: number;  // ID of Brand
  @IsOptional()@Type(() => Number)@IsNumber()@Min(0)minPrice?: number;
  @IsOptional()@Type(() => Number)@IsNumber()@Min(0)maxPrice?: number;
  @IsOptional()@Type(() => Number)@IsNumber()category?: number;  // ID of Category
  @IsOptional()@Type(() => Number)@IsNumber()subCategory?: number;  // ID of SubCategory
  @IsOptional()@Type(() => Number)@IsNumber()fuelType?: number;  // ID of FuelType
  @IsOptional()@IsIn(['id_asc', 'price_asc', 'price_desc', 'year_asc', 'year_desc', 'review_asc', 'review_desc'])
  sort?: string;
  @IsOptional()@Type(() => Number)@IsNumber()@Min(1)page?: number;
  @IsOptional()@Type(() => Number)@IsNumber()@Min(1)@Max(100)pageSize?: number;
}
