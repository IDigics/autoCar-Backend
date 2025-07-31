import { Controller, Get } from '@nestjs/common';
import { FuelTypeService } from './fuel-type.service';

@Controller('fuel')
export class FuelTypeController {
  constructor(private readonly fuelTypeService: FuelTypeService) {}

  @Get()
  async getAll() {
    return this.fuelTypeService.getAll();
  }
}
