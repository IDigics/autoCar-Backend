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
import { CarImage } from '../car-image/car-image.entity'; 

@Injectable()
export class ImportService {
  constructor(
    @InjectRepository(Car) private carRepo: Repository<Car>,
    @InjectRepository(Brand) private brandRepo: Repository<Brand>,
    @InjectRepository(Category) private categoryRepo: Repository<Category>,
    @InjectRepository(SubCategory) private subCategoryRepo: Repository<SubCategory>,
    @InjectRepository(FuelType) private fuelTypeRepo: Repository<FuelType>,
    @InjectRepository(CarImage) private carImageRepo: Repository<CarImage>, 
  ) {}

  async importData(filePath: string): Promise<{ importedCount: number }> {
    const rows = await this.readCsv(filePath);

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

    let importedCount = 0;
    for (const row of rows) {
      const brand = await this.brandRepo.findOne({ where: { name: row.brand.trim() } });
      const fuel = await this.fuelTypeRepo.findOne({ where: { type: row.fuel.trim() } });
      const category = await this.categoryRepo.findOne({ where: { name: row.category.trim() } });
      const subCategory = await this.subCategoryRepo.findOne({ where: { name: row.subcategory.trim() } });

      if (!brand || !fuel || !category || !subCategory) {
        console.log(`Skipping row id ${row.id} due to missing relation`);
        continue;
      }

      const car = this.carRepo.create({
        mileage: Number(row.mileage || 0),
        brand,
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
        category,
        subCategory,
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

  async assignDefaultImagesByBrand() {
    const brandImageMap = {
      1: 'e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp',
      2: 'f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp',
      3: '697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp',
      4: '449dd01d-7a1b-4e53-9d69-81b763e6de95.webp',
      5: '1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp',
      6: '09ac2ed6-9017-4cab-8fc9-8701bd002571.webp',
      7: '33a9db78-9092-4281-8702-eb5130abcf98.webp',
      8: '6a97f6ac-803c-4ff6-b936-11ce65c48592.webp',
      9: '96638e03-5945-4aaa-991f-8126e5f9b0ac.webp',
      10: 'a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp',
    };

    const allCars = await this.carRepo.find({ relations: ['brand'] });

    const carImages = allCars
      .map((car) => {
        const url = brandImageMap[car.brand.id];
        if (!url) return null;

        return this.carImageRepo.create({
          car: car,
          url: url,
        });
      })
      .filter((img): img is CarImage => img !== null);

    await this.carImageRepo.save(carImages);

    console.log(`✅ Added ${carImages.length} car images`);
  }

}
