import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as fs from 'fs/promises';
import * as path from 'path';
import * as sharp from 'sharp';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class CarImageService {
  public readonly uploadFolder: string;

  constructor(private configService: ConfigService) {
    this.uploadFolder = this.configService.get<string>('UPLOAD_FOLDER') || 'uploads';
  }

  async processAndSaveImage(file: Express.Multer.File): Promise<string> {
    await fs.mkdir(this.uploadFolder, { recursive: true });

    const filename = `${uuidv4()}.webp`;
    const filepath = path.join(this.uploadFolder, filename);

    await sharp(file.buffer)
      .webp({ quality: 80 })
      .toFile(filepath);

    return filename;
  }

  async processAndSaveImages(files: Express.Multer.File[]): Promise<string[]> {
    await fs.mkdir(this.uploadFolder, { recursive: true });

    const filenames: string[] = [];

    for (const file of files) {
      const filename = `${uuidv4()}.webp`;
      const filepath = path.join(this.uploadFolder, filename);

      await sharp(file.buffer)
        .webp({ quality: 80 })
        .toFile(filepath);

      filenames.push(filename);
    }

    return filenames;
  }
}
