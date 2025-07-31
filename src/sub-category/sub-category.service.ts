import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Not, Repository } from 'typeorm';
import { SubCategory } from './sub-category.entity';

@Injectable()
export class SubCategoryService {
  constructor(
    @InjectRepository(SubCategory)
    private subCategoryRepo: Repository<SubCategory>,
  ) {}

  async getAll(): Promise<SubCategory[]> {
    return this.subCategoryRepo.find();
  }

  async getById(id: number): Promise<SubCategory> {
    const subCategory = await this.subCategoryRepo.findOne({ where: { id } });
    if (!subCategory) throw new NotFoundException(`Sub-category with id ${id} not found.`);
    return subCategory;
  }

  async create(name: string): Promise<{ message: string }> {
    const exists = await this.subCategoryRepo.findOne({
      where: { name: ILike(name) },
    });
    if (exists) throw new BadRequestException('Sub-category with this name already exists.');

    const subCategory = this.subCategoryRepo.create({ name });
    await this.subCategoryRepo.save(subCategory);

    return { message: 'Sub-category is successfully added' };
  }

  async update(id: number, name: string): Promise<{ message: string }> {
    const subCategory = await this.getById(id);

    const nameExists = await this.subCategoryRepo.findOne({
      where: { name: ILike(name), id: Not(id) },
    });
    if (nameExists) throw new BadRequestException('Another sub-category with this name already exists.');

    subCategory.name = name;
    await this.subCategoryRepo.save(subCategory);

    return { message: 'Sub-category is successfully updated' };
  }

  async delete(id: number): Promise<void> {
    const subCategory = await this.getById(id);
    await this.subCategoryRepo.remove(subCategory);
  }
}
