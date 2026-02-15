import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FuelType} from './fuel-type.entity';
import { FuelTypeService } from './fuel-type.service';
import { FuelTypeController } from './fuel-type.controller';

@Module({
  imports: [TypeOrmModule.forFeature([FuelType])],
  providers: [FuelTypeService],
  controllers: [FuelTypeController],
  exports: [FuelTypeService],
})
export class FuelTypeModule {}