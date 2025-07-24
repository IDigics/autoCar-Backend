import { IsBoolean, IsInt, IsOptional, IsString } from "class-validator";

export class UpdateCarDto {
  @IsOptional() @IsString() model?: string;
  @IsOptional() @IsString() brand?: string;
  @IsOptional() @IsInt() mileage?: number;
  @IsOptional() @IsInt() previousOwner?: number;
  @IsOptional() @IsString() offerType?: string;

  @IsOptional() @IsInt() categoryId?: number;
  @IsOptional() @IsInt() subCategoryId?: number;
  @IsOptional() @IsInt() fuelTypeId?: number;

  @IsOptional() @IsBoolean() removeMainImage?: boolean;

  @IsOptional() deletedImageIds?: number[];
}
