import { Controller, Get, Param, ParseIntPipe, Query, UsePipes, ValidationPipe } from '@nestjs/common';
import { CarService } from './car.service';
import { CarFilterDto } from './dto/car-filter.dto';

@Controller('cars')
export class CarController {
  constructor(private readonly carService: CarService) {}

  @Get()
  @UsePipes(new ValidationPipe({ transform: true, whitelist: true }))
  async getCars(@Query() filters: CarFilterDto) {
    // Destructure with default values
    const {
      brand,
      minPrice,
      maxPrice,
      category,
      subCategory,
      fuelType,
      sort = 'id_asc',
      page = 1,
      pageSize = 10,
      search,
    } = filters;

    // Build filter object dynamically, skipping undefined/null values
    const filterObject = {
      ...(brand !== undefined && brand !== null && { brand }),
      ...(minPrice !== undefined && { minPrice }),
      ...(maxPrice !== undefined && { maxPrice }),
      ...(category !== undefined && category !== null && { category }),
      ...(subCategory !== undefined && subCategory !== null && { subCategory }),
      ...(fuelType !== undefined && fuelType !== null && { fuelType }),
      ...(search && { search }),
    };

    // Call service method with filters, pagination and sorting
    return this.carService.getCars(filterObject, sort, page, pageSize);
  }
  @Get(':id')
  async getCarById(@Param('id', ParseIntPipe) id: number) {
  return this.carService.getCarById(id);
  }
  @Get('minmaxprice')
    async getMinMaxPrice() {
    return this.carService.getMinMaxPrice();
    }
}
