import { Controller, Get, Param, ParseIntPipe, Query } from '@nestjs/common';
import { RecommendationService } from './recommendation.service';
import { Car } from '../car/car.entity';

@Controller('recommendation')
export class RecommendationController {
  constructor(private readonly recommendationService: RecommendationService) {}

  @Get('car/:id')
  async getRecommendations(
    @Param('id', ParseIntPipe) id: number,
    @Query('n') n: string
  ): Promise<Car[]> {
    const count = n ? parseInt(n, 10) : 3;
    return this.recommendationService.getRecommendationsForCar(id, count);
  }
}
