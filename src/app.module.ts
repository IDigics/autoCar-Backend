import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CarModule } from './car/car.module';
import { BrandModule } from './brand/brand.module';
import { CategoryModule } from './category/category.module';
import { SubCategoryModule } from './sub-category/sub-category.module';
import { FuelTypeModule } from './fuel-type/fuel-type.module';
import { CarImageModule } from './car-image/car-image.module';
import { ReviewModule } from './review/review.module';
import { RecommendationModule } from './recommendation/recommendation.module';
import { RecommendedCarModule } from './recommended-car/recommended-car.module';

@Module({
  imports: [TypeOrmModule.forRoot({
    type: 'postgres',
    host: process.env.DB_HOST,
    port: +(process.env.DB_PORT || 5432),
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    autoLoadEntities: true,
    synchronize: true, // false in production
  }), CarModule, BrandModule, CategoryModule, SubCategoryModule, FuelTypeModule, CarImageModule, ReviewModule, RecommendationModule, RecommendedCarModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
