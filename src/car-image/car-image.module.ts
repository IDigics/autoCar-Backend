import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CarImage} from './car-image.entity';
import { CarImageService } from './car-image.service';

@Module({
  imports: [TypeOrmModule.forFeature([CarImage])],
  providers: [CarImageService],
  exports: [TypeOrmModule],
})
export class CarImageModule {}