import {IsString,IsEnum,IsInt,IsNumber,IsOptional,} from 'class-validator';

export class CreateCarDto {
  @IsString() brand: string;
  @IsString() model: string;
  @IsString() fuelType: string;
  @IsEnum(['Automatic', 'Manual']) gear: 'Automatic' | 'Manual';
  @IsEnum(['new', 'used']) offerType: 'new' | 'used';
  @IsInt() price: number;
  @IsInt() horsePower: number;
  @IsInt() year: number;
  @IsNumber() engineSize: number;
  @IsInt() doors: number;
  @IsInt() seats: number;
  @IsString() color: string;

  @IsString() category: string;
  @IsString() subCategory: string;

  @IsOptional() @IsInt() mileage?: number;
  @IsOptional() @IsInt() previousOwner?: number;
}
