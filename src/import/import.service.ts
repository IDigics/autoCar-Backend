import { Injectable } from '@nestjs/common';
import * as fs from 'fs';
import * as csvParser from 'csv-parser';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Car } from '../car/car.entity';
import { Brand } from '../brand/brand.entity';
import { Category } from '../category/category.entity';
import { SubCategory } from '../sub-category/sub-category.entity';
import { FuelType } from '../fuel-type/fuel-type.entity';

@Injectable()
export class ImportService {
  constructor(
    @InjectRepository(Car) private carRepo: Repository<Car>,
    @InjectRepository(Brand) private brandRepo: Repository<Brand>,
    @InjectRepository(Category) private categoryRepo: Repository<Category>,
    @InjectRepository(SubCategory) private subCategoryRepo: Repository<SubCategory>,
    @InjectRepository(FuelType) private fuelTypeRepo: Repository<FuelType>,
  ) {}

  async importData(filePath: string): Promise<{ importedCount: number }> {
    const rows = await this.readCsv(filePath);

    // 1. Extract unique related data
    const uniqueBrands = new Set<string>();
    const uniqueFuels = new Set<string>();
    const uniqueCategories = new Set<string>();
    const uniqueSubCategories = new Set<string>();

    for (const row of rows) {
      uniqueBrands.add(row.brand.trim());
      uniqueFuels.add(row.fuel.trim());
      uniqueCategories.add(row.category.trim());
      uniqueSubCategories.add(row.subcategory.trim());
    }

    // 2. Insert related entities if not exists
    for (const brandName of uniqueBrands) {
      let brand = await this.brandRepo.findOne({ where: { name: brandName } });
      if (!brand) {
        brand = this.brandRepo.create({ name: brandName });
        await this.brandRepo.save(brand);
      }
    }

    for (const fuelName of uniqueFuels) {
      let fuel = await this.fuelTypeRepo.findOne({ where: { type: fuelName } });
      if (!fuel) {
        fuel = this.fuelTypeRepo.create({ type: fuelName });
        await this.fuelTypeRepo.save(fuel);
      }
    }

    for (const categoryName of uniqueCategories) {
      let category = await this.categoryRepo.findOne({ where: { name: categoryName } });
      if (!category) {
        category = this.categoryRepo.create({ name: categoryName });
        await this.categoryRepo.save(category);
      }
    }

    for (const subCategoryName of uniqueSubCategories) {
      let subCategory = await this.subCategoryRepo.findOne({ where: { name: subCategoryName } });
      if (!subCategory) {
        subCategory = this.subCategoryRepo.create({ name: subCategoryName });
        await this.subCategoryRepo.save(subCategory);
      }
    }

    // 3. Import cars with proper relations
    let importedCount = 0;
    for (const row of rows) {
      const brand = await this.brandRepo.findOne({ where: { name: row.brand.trim() } });
      const fuel = await this.fuelTypeRepo.findOne({ where: { type: row.fuel.trim() } });
      const category = await this.categoryRepo.findOne({ where: { name: row.category.trim() } });
      const subCategory = await this.subCategoryRepo.findOne({ where: { name: row.subcategory.trim() } });

      if (!brand || !fuel || !category || !subCategory) {
        console.log(`Skipping row id ${row.id} because related entity is missing.`);
        continue; // skip or handle error
      }

      const car = this.carRepo.create({
        mileage: Number(row.mileage || 0),
        brand: brand,
        model: row.model,
        fuelType: fuel,
        gear: row.gear,
        offerType: row.offerType,
        price: parseInt(row.price),
        horsePower: parseInt(row['horse power']),
        year: parseInt(row.year),
        engineSize: parseFloat(row['engine size']),
        doors: parseInt(row.doors),
        seats: parseInt(row.seats),
        previousOwner: parseInt(row['previous owner']),
        color: row.color,
        category: category,
        subCategory: subCategory,
      });

      await this.carRepo.save(car);
      importedCount++;
    }

    return { importedCount };
  }

private readCsv(filePath: string): Promise<any[]> {
  return new Promise((resolve, reject) => {
    const results: any[] = []; 
    fs.createReadStream(filePath)
      .pipe(csvParser())
      .on('data', (data) => results.push(data))
      .on('end', () => resolve(results))
      .on('error', (error) => reject(error));
  });
}
async getMinMaxPrice(): Promise<{ minPrice: number; maxPrice: number }> {
  const min = await this.carRepo
    .createQueryBuilder('car')
    .select('MIN(car.price)', 'min')
    .getRawOne();

  const max = await this.carRepo
    .createQueryBuilder('car')
    .select('MAX(car.price)', 'max')
    .getRawOne();

  return {
    minPrice: parseInt(min.min),
    maxPrice: parseInt(max.max),
  };
}

  }
