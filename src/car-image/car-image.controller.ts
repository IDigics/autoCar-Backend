import {
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { CarImageService } from './car-image.service';

@Controller('carimage')
export class CarImageController {
  constructor(private readonly imageService: CarImageService) {}

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async upload(@UploadedFile() file: Express.Multer.File) {
    const filename = await this.imageService.processAndSaveImage(file);
    return { filename };
  }
}
