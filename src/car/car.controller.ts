import { BadRequestException, Body, Controller, Delete, Get, NotFoundException, Param, ParseIntPipe, Post, Put, Query, UploadedFile, UploadedFiles, UseInterceptors, UsePipes, ValidationPipe } from '@nestjs/common';
import { CarService } from './car.service';
import { CarFilterDto } from './dto/car-filter.dto';
import {FileFieldsInterceptor,FileInterceptor, FilesInterceptor } from '@nestjs/platform-express';
import { CreateCarDto } from './dto/create-car.dto';
import { UpdateCarDto } from './dto/update-car.dto';

@Controller('cars')
export class CarController {
  carImageService: any;
  constructor(private readonly carService: CarService) {}

  @Get('minmaxprice')
    async getMinMaxPrice() {
    return this.carService.getMinMaxPrice();
    }

  @Get(':id')
    async getCarById(@Param('id', ParseIntPipe) id: number) {
    return this.carService.getCarById(id);
    }

  @Post()
  @UseInterceptors(
    FileFieldsInterceptor([
      { name: 'mainImage', maxCount: 1 },
      { name: 'secondaryImages', maxCount: 10 },
    ]),
  )
  async createCar(
    @Body() carDto: CreateCarDto,
    @UploadedFiles()
    files: {
      mainImage?: Express.Multer.File[],
      secondaryImages?: Express.Multer.File[],
    },
  ) {
    const mainImage = files.mainImage?.[0];
    if (!mainImage) {
      throw new BadRequestException('Main image is required');
    }
    const secondaryImages = files.secondaryImages || [];
    await this.carService.createCar(carDto, mainImage, secondaryImages);
    return { message: 'Car created successfully' };
  }


  @Put(':id')
  @UseInterceptors(
    FileFieldsInterceptor([
      { name: 'mainImage', maxCount: 1 },
      { name: 'secondaryImages', maxCount: 10 },
    ]),
  )
  async updateCar(
    @Param('id') id: string,
    @Body() dto: UpdateCarDto,
    @UploadedFiles() files: {
      mainImage?: Express.Multer.File[],
      secondaryImages?: Express.Multer.File[],
    },
  ) {
    const mainImage = files.mainImage?.[0];
    const secondaryImages = files.secondaryImages || [];

    return this.carService.updateCar(+id, dto, mainImage, secondaryImages);
  }

  @Delete(':id')
  async deleteCar(@Param('id', ParseIntPipe) id: number) {
    await this.carService.deleteCar(id);
    return { message: 'Car deleted successfully' };
  }

  
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
  

}
