import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ILike, Not, Repository } from 'typeorm';
import { FuelType } from './fuel-type.entity';

@Injectable()
export class FuelTypeService {
  constructor(
    @InjectRepository(FuelType)
    private fuelRepo: Repository<FuelType>,
  ) {}

  async getAll(): Promise<FuelType[]> {
    return this.fuelRepo.find();
  }

  async getById(id: number): Promise<FuelType> {
    const fuel = await this.fuelRepo.findOne({ where: { id } });
    if (!fuel) throw new NotFoundException(`Fuel type with id ${id} not found.`);
    return fuel;
  }

  async create(type: string): Promise<{ message: string }> {
    const exists = await this.fuelRepo.findOne({ where: { type: ILike(type) } });
    if (exists) throw new BadRequestException('Fuel type with this name already exists.');

    const fuel = this.fuelRepo.create({ type });
    await this.fuelRepo.save(fuel);

    return { message: 'Fuel type is successfully added' };
  }

  async update(id: number, type: string): Promise<{ message: string }> {
    const fuel = await this.getById(id);

    const nameExists = await this.fuelRepo.findOne({
      where: {
        type: ILike(type),
        id: Not(id),
      },
    });
    if (nameExists) throw new BadRequestException('Another fuel type with this name already exists.');

    fuel.type = type;
    await this.fuelRepo.save(fuel);

    return { message: 'Fuel type is successfully updated' };
  }

  async delete(id: number): Promise<void> {
    const fuel = await this.getById(id);
    await this.fuelRepo.remove(fuel);
  }
}
