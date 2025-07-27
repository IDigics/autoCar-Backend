import { IsOptional, IsString, IsEnum, IsInt, IsBoolean, IsArray } from 'class-validator';
import { Type } from 'class-transformer';

export class UpdateCarDto {
  @IsOptional() @IsString() model?: string;
  @IsOptional() @IsEnum(['Automatic', 'Manual']) gear?: 'Automatic' | 'Manual';
  @IsOptional() @IsEnum(['new', 'used']) offerType?: 'new' | 'used';
  @IsOptional() @Type(() => Number) @IsInt() price?: number;
  @IsOptional() @Type(() => Number) @IsInt() horsePower?: number;
  @IsOptional() @Type(() => Number) @IsInt() year?: number;
  @IsOptional() @Type(() => Number) engineSize?: number;
  @IsOptional() @Type(() => Number) @IsInt() doors?: number;
  @IsOptional() @Type(() => Number) @IsInt() seats?: number;
  @IsOptional() @IsString() color?: string;
  @IsOptional() @Type(() => Number) @IsInt() mileage?: number;
  @IsOptional() @Type(() => Number) @IsInt() previousOwner?: number;

  @IsOptional() @Type(() => Number) @IsInt() brandId?: number;
  @IsOptional() @Type(() => Number) @IsInt() fuelTypeId?: number;
  @IsOptional() @Type(() => Number) @IsInt() categoryId?: number;
  @IsOptional() @Type(() => Number) @IsInt() subCategoryId?: number;

  // Image management fields
  @IsOptional() @IsArray() @Type(() => Number) deletedImageIds?: number[];  // secondary images to delete
}
