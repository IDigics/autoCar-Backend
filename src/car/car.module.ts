import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from './car.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Car])],
  providers: [],
  controllers: [],
})
export class CarModule {}