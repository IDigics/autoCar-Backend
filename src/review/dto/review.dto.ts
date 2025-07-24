import {IsString,IsEmail, IsInt, Min, Max} from 'class-validator';

export class CreateReviewDto {
  @IsEmail() email: string;
  @IsInt()@Min(1)@Max(5)score: number;  
  @IsString() comment: string;
}

