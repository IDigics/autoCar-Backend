import { Injectable } from '@nestjs/common';
import { BrandService } from '../brand/brand.service';
import { CategoryService } from '../category/category.service';
import { SubCategoryService } from '../sub-category/sub-category.service';
import { FuelTypeService } from '../fuel-type/fuel-type.service';
import { CarService } from 'src/car/car.service';

@Injectable()
export class FilterDataService {
  constructor(
    private readonly brandService: BrandService,
    private readonly categoryService: CategoryService,
    private readonly subCategoryService: SubCategoryService,
    private readonly fuelTypeService: FuelTypeService,
    private readonly CarService: CarService,
  ) {}

  async getAllFilters() {
    const [brands, categories, subCategories, fuelTypes,MinMax] = await Promise.all([
      this.brandService.getAll(),
      this.categoryService.getAll(),
      this.subCategoryService.getAll(),
      this.fuelTypeService.getAll(),
      this.CarService.getMinMaxPrice(),
    ]);

    return {
      brands,
      categories,
      subCategories,
      fuelTypes,
      MinMax,
    };
  }
}
