import { Controller, Get } from '@nestjs/common';
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

}
