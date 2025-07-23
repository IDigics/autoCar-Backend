import { Controller, Get, Query, UsePipes, ValidationPipe } from '@nestjs/common';
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
    } = filters;

    // Build filter object dynamically, skipping undefined/null values
    const filterObject = {
      ...(brand !== undefined && brand !== null && { brand }),
      ...(minPrice !== undefined && { minPrice }),
      ...(maxPrice !== undefined && { maxPrice }),
      ...(category !== undefined && category !== null && { category }),
      ...(subCategory !== undefined && subCategory !== null && { subCategory }),
      ...(fuelType !== undefined && fuelType !== null && { fuelType }),
    };

    // Call service method with filters, pagination and sorting
    return this.carService.getCars(filterObject, sort, page, pageSize);
  }

  @Get('minmaxprice')
    async getMinMaxPrice() {
    return this.carService.getMinMaxPrice();
    }
}
