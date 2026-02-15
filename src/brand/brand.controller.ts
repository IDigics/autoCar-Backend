import {Controller,Param,Body,UploadedFile,UseInterceptors,ParseIntPipe,BadRequestException,Get,Put} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { BrandService } from './brand.service';
import { Express } from 'express';

@Controller('brands')
export class BrandController {
  constructor(private readonly brandService: BrandService) {}

  @Get()
  async getAll() {
    return this.brandService.getAll();
  }

  @Put(':id')
  @UseInterceptors(FileInterceptor('logo'))
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body('name') name?: string,
    @UploadedFile() logo?: Express.Multer.File,
  ) {
    // Validate name only if present
    if (name !== undefined && typeof name !== 'string') {
      throw new BadRequestException('Name must be a string');
    }

    return this.brandService.update(id, name, logo);
  }
}
