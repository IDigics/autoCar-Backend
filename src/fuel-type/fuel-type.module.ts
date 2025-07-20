import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FuelType} from './fuel-type.entity';

@Module({
  imports: [TypeOrmModule.forFeature([FuelType])],
  providers: [],
  controllers: [],
})
export class FuelTypeModule {}