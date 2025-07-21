import { CacheModule } from '@nestjs/cache-manager';

import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from './car.entity';
import { CarService } from './car.service';
import { CarController } from './car.controller';

@Module({
  imports: [
    CacheModule.register(),
    TypeOrmModule.forFeature([Car])],
  providers: [CarService],
  controllers: [CarController],
})
export class CarModule {}