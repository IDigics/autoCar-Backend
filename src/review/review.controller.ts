import { Controller, Post, Get, Param, Body, ParseIntPipe, UsePipes, ValidationPipe } from '@nestjs/common';
import { ReviewService } from './review.service';
import { CreateReviewDto } from './dto/review.dto';

@Controller('cars/:carId/reviews')
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}

  @Post()
  @UsePipes(new ValidationPipe({ whitelist: true, transform: true }))
  async createReview(
    @Param('carId', ParseIntPipe) carId: number,
    @Body() createReviewDto: CreateReviewDto,
  ) {
    return this.reviewService.createReview(carId, createReviewDto);
  }

  @Get()
  async getReviews(@Param('carId', ParseIntPipe) carId: number) {
    return this.reviewService.getReviewsByCarId(carId);
  }
}
