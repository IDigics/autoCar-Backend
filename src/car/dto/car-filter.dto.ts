import { IsOptional, IsNumber, IsArray, ArrayNotEmpty, IsString, IsIn } from 'class-validator';
import { Transform, Type } from 'class-transformer';

function parseCommaSeparatedNumbers(value: any): number[] | undefined {
  if (!value) return undefined;
  if (Array.isArray(value)) {
    return value.map(v => Number(v)).filter(n => !isNaN(n));
  }
  if (typeof value === 'string') {
    return value
      .split(',')
      .map(v => Number(v.trim()))
      .filter(n => !isNaN(n));
  }
  return undefined;
}

export class CarFilterDto {
  @IsOptional()
  @IsArray()
  @ArrayNotEmpty()
  @IsNumber({}, { each: true })
  @Transform(({ value }) => parseCommaSeparatedNumbers(value))
  brand?: number[];

  @IsOptional()
  @IsArray()
  @ArrayNotEmpty()
  @IsNumber({}, { each: true })
  @Transform(({ value }) => parseCommaSeparatedNumbers(value))
  category?: number[];

  @IsOptional()
  @IsArray()
  @ArrayNotEmpty()
  @IsNumber({}, { each: true })
  @Transform(({ value }) => parseCommaSeparatedNumbers(value))
  subCategory?: number[];

  @IsOptional()
  @IsArray()
  @ArrayNotEmpty()
  @IsNumber({}, { each: true })
  @Transform(({ value }) => parseCommaSeparatedNumbers(value))
  fuelType?: number[];

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  minPrice?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  maxPrice?: number;

  @IsOptional()
  @IsString()
  search?: string;

  @IsOptional()
  @IsIn([
    'id_asc',
    'price_asc',
    'price_desc',
    'year_asc',
    'year_desc',
    'review_asc',
    'review_desc',
  ])
  sort?: string;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  page?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  pageSize?: number;
}
