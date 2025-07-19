import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CarImage} from './car-image.entity';

@Module({
  imports: [TypeOrmModule.forFeature([CarImage])],
  providers: [],
  controllers: [],
})
export class CarImageModule {}