import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { ILike, Not, Repository } from 'typeorm';
import { Brand } from './brand.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class BrandService {
  constructor(
    @InjectRepository(Brand)
    private brandRepo: Repository<Brand>,
  ) {}

  async getAll(): Promise<Brand[]> {
    return this.brandRepo.find();
  }

  async getById(id: number): Promise<Brand> {
    const brand = await this.brandRepo.findOne({ where: { id } });
    if (!brand) throw new NotFoundException(`Brand with id ${id} not found.`);
    return brand;
  }

  async create(name: string): Promise<{ message: string }> {
    const exists = await this.brandRepo.findOne({where: { name: ILike(name) },});
    if (exists) throw new BadRequestException('Brand with this name already exists.');

    const brand = this.brandRepo.create({ name });
    await this.brandRepo.save(brand);

  return { message: 'Brand is successfully added' };
  }


  async update(id: number, name: string): Promise<{message:string}> {
    const brand = await this.getById(id);

    const nameExists = await this.brandRepo.findOne({where: {name: ILike(name),id: Not(id),},});
    if (nameExists) throw new BadRequestException('Another brand with this name already exists.');

    brand.name = name;
    return {message:"brand is successfully updated"};
  }

  async delete(id: number): Promise<void> {
    const brand = await this.getById(id);
    await this.brandRepo.remove(brand);
  }
}
