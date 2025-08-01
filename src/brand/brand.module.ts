import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Brand } from './brand.entity';
import { BrandService } from './brand.service';
import { BrandController } from './brand.controller';
import { CarImageModule } from 'src/car-image/car-image.module';

@Module({
  imports: [TypeOrmModule.forFeature([Brand]),CarImageModule],
  providers: [BrandService],
  controllers: [BrandController],
  exports: [TypeOrmModule,BrandService],
})
export class BrandModule {}
