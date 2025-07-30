import { Controller, Post, Get, Param, Body, Query, ParseIntPipe, UsePipes, ValidationPipe, BadRequestException } from '@nestjs/common';
import { ReviewService } from './review.service';
import { CreateReviewDto } from './dto/review.dto';

@Controller('cars/reviews')
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}

  @Post(':carId')
  @UsePipes(new ValidationPipe({ whitelist: true, transform: true }))
  async createReview(
    @Param('carId', ParseIntPipe) carId: number,
    @Body() createReviewDto: CreateReviewDto,
  ) {
    return this.reviewService.createReview(carId, createReviewDto);
  }

@Get(':carId')
async getReviews(
  @Param('carId', ParseIntPipe) carId: number,
  @Query('limit') limit?: string,
) {
  const parsedLimit = limit ? parseInt(limit, 10) : 10;

  if (limit && isNaN(parsedLimit)) {
    throw new BadRequestException('limit must be a valid number');
  }

  return this.reviewService.getReviewsByCarId(carId, parsedLimit);
}

}
