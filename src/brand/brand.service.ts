import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { ILike, Not, Repository } from 'typeorm';
import { Brand } from './brand.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { CarImageService } from 'src/car-image/car-image.service';

@Injectable()
export class BrandService {
  constructor(
    @InjectRepository(Brand)
    private brandRepo: Repository<Brand>,
    private imageService: CarImageService,

  ) {}

  async getAll(): Promise<Brand[]> {
    return this.brandRepo.find();
  }

  async getById(id: number): Promise<Brand> {
    const brand = await this.brandRepo.findOne({ where: { id } });
    if (!brand) throw new NotFoundException(`Brand with id ${id} not found.`);
    return brand;
  }

async create(name: string, logo: Express.Multer.File): Promise<{ message: string }> {
    const exists = await this.brandRepo.findOne({ where: { name: ILike(name) } });
    if (exists) throw new BadRequestException('Brand with this name already exists.');

    if (!logo) throw new BadRequestException('Logo image is required');

    const savedLogo = await this.imageService.processAndSaveImage(logo);

    const brand = this.brandRepo.create({ name, logo: savedLogo });
    await this.brandRepo.save(brand);

    return { message: 'Brand is successfully added' };
  }

async update(
  id: number,
  name?: string,
  newLogo?: Express.Multer.File,
): Promise<{ message: string }> {
  const brand = await this.getById(id);

  if (name !== undefined) {
    const nameExists = await this.brandRepo.findOne({
      where: { name: ILike(name), id: Not(id) },
    });
    if (nameExists) throw new BadRequestException('Another brand with this name already exists.');

    brand.name = name;
  }

  if (newLogo) {
    if (brand.logo) {
      await this.imageService.deleteImage(brand.logo);
    }
    brand.logo = await this.imageService.processAndSaveImage(newLogo);
  }

  await this.brandRepo.save(brand);
  return { message: 'Brand is successfully updated' };
}


  async delete(id: number): Promise<void> {
    const brand = await this.getById(id);
    await this.brandRepo.remove(brand);
  }
}
