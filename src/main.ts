import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.enableCors({
    origin: process.env.ORIGIN,
    methods: 'GET,POST,PUT,PATCH,DELETE',
    credentials: true,
  });
onst uploadFolder = process.env.UPLOAD_FOLDER || '/app/uploads';
  app.useStaticAssets(join(__dirname, '..', uploadFolder), {
   prefix: '/image/',
 });

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
