import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Category } from './category.entity';
import { ILike, Not, Repository } from 'typeorm';

@Injectable()
export class CategoryService {
  constructor(
    @InjectRepository(Category)
    private categoryRepo: Repository<Category>,
  ) {}

  async getAll(): Promise<Category[]> {
    return this.categoryRepo.find();
  }

  async getById(id: number): Promise<Category> {
    const category = await this.categoryRepo.findOne({ where: { id } });
    if (!category) throw new NotFoundException(`Category with id ${id} not found.`);
    return category;
  }

  async create(name: string): Promise<{ message: string }> {
    const exists = await this.categoryRepo.findOne({ where: { name: ILike(name) } });
    if (exists) throw new BadRequestException('Category with this name already exists.');

    const category = this.categoryRepo.create({ name });
    await this.categoryRepo.save(category);

    return { message: 'Category is successfully added' };
  }

  async update(id: number, name: string): Promise<{ message: string }> {
    const category = await this.getById(id);

    const nameExists = await this.categoryRepo.findOne({
      where: { name: ILike(name), id: Not(id) },
    });
    if (nameExists) throw new BadRequestException('Another category with this name already exists.');

    category.name = name;
    await this.categoryRepo.save(category);

    return { message: 'Category is successfully updated' };
  }

  async delete(id: number): Promise<void> {
    const category = await this.getById(id);
    await this.categoryRepo.remove(category);
  }
}
