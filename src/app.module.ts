import { Module,Logger } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';



import { CarModule } from './car/car.module';
import { BrandModule } from './brand/brand.module';
import { CategoryModule } from './category/category.module';
import { SubCategoryModule } from './sub-category/sub-category.module';
import { FuelTypeModule } from './fuel-type/fuel-type.module';
import { CarImageModule } from './car-image/car-image.module';
import { ReviewModule } from './review/review.module';
import { RecommendationModule } from './recommendation/recommendation.module';
import { RecommendedCarModule } from './recommended-car/recommended-car.module';
import { ImportModule } from './import/import.module';

@Module({
  imports: [ 
  ConfigModule.forRoot({ isGlobal: true }),
  TypeOrmModule.forRootAsync({
    imports: [ConfigModule],
    inject: [ConfigService],
    useFactory: (config: ConfigService) => ({
      type: 'postgres',
      host: config.get<string>('DB_HOST'),
      port: config.get<number>('DB_PORT'),
      username: config.get<string>('DB_USERNAME'),
      password: config.get<string>('DB_PASSWORD'),
      database: config.get<string>('DB_NAME'),
      synchronize: false, //in prod it go flase
      autoLoadEntities: true,
    })
    }),
    CarModule,
    BrandModule, 
    CategoryModule, 
    SubCategoryModule, 
    FuelTypeModule, 
    CarImageModule, 
    ReviewModule, 
    RecommendationModule, 
    RecommendedCarModule, 
    ImportModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
