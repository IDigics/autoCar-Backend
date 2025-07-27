import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Brand } from './brand.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Brand])],
  providers: [],
  controllers: [],
  exports: [TypeOrmModule],
})
export class BrandModule {}
