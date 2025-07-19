import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recommendation} from './recommendation.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Recommendation])],
  providers: [],
  controllers: [],
})
export class RecommendationModule {}