import { Controller, Get } from '@nestjs/common';
import { FilterDataService } from './filter-data.service';

@Controller('filters')
export class FilterDataController {
  constructor(private readonly filterDataService: FilterDataService) {}

  @Get()
  async getFilters() {
    return this.filterDataService.getAllFilters();
  }
}
