import { Controller, Get, Post } from '@nestjs/common';
import { ImportService } from './import.service';

@Controller('import')
export class ImportController {
  constructor(private readonly importService: ImportService) {}

  @Get('cars')
    async importCars() {
      const cars=await this.importService.importData('carDataset.csv');
      return cars;
    }
  @Get('minmaxprice')
    async getMinMaxPrice() {
      return this.importService.getMinMaxPrice();
    }

  @Post('default')
  async seedDefaultImages() {
    return this.importService.assignDefaultImagesByBrand();
  }
  @Post('setmain')
  async setImagesToMain() {
    await this.importService.setAllImagesToMain();
    return { message: 'All car images updated to main' };
  }
}
