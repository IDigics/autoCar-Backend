import { Controller, Get } from '@nestjs/common';
import { SubCategoryService } from './sub-category.service';

@Controller('subCategories')
export class SubCategoryController {
  constructor(private readonly subCategoryService: SubCategoryService) {}

  @Get()
  async getAll() {
    return this.subCategoryService.getAll();
  }
}
