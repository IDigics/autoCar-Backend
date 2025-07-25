import { Type } from 'class-transformer';
import {IsString,IsEnum,IsInt,IsNumber,IsOptional,} from 'class-validator';

export class CreateCarDto {
  @IsString() model: string;
  @IsEnum(['Automatic', 'Manual']) gear: 'Automatic' | 'Manual';
  @IsEnum(['new', 'used']) offerType: 'new' | 'used';
  @IsInt() price: number;
  @IsInt() horsePower: number;
  @IsInt() year: number;
  @IsNumber() engineSize: number;
  @IsInt() doors: number;
  @IsInt() seats: number;
  @IsString() color: string;
  @IsOptional() @IsInt() mileage?: number;
  @IsOptional() @IsInt() previousOwner?: number;

   //FKs will used with a dropdown in front flow :get brands,fuel,category,subcategory ou pickchanges
  @Type(() => Number) @IsInt() 
  brandId?: number;
  @Type(() => Number) @IsInt() 
  fuelTypeId?: number;
  @Type(() => Number) @IsInt() 
  categoryId?: number;
  @Type(() => Number) @IsInt() 
  subCategoryId?: number;
}
