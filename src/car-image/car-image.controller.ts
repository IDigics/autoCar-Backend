import {
  Controller,
  Get,
  Param,
  Res,
  NotFoundException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Response } from 'express';
import { join } from 'path';
import { createReadStream, existsSync } from 'fs';

@Controller('image')
export class CarImageController {
  constructor(private configService: ConfigService) {}

  /*@Get(':filename')
  async serveImage(@Param('filename') filename: string, @Res() res: Response) {
    const uploadFolder = this.configService.get<string>('UPLOAD_FOLDER') || 'uploads/car-images';
    const filePath = join(__dirname, '..', '..', uploadFolder, filename);

    if (!existsSync(filePath)) {
      throw new NotFoundException('Image not found');
    }

    const stream = createReadStream(filePath);
    stream.pipe(res);
  }*/
}