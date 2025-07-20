import { Entity, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { Car } from '../car/car.entity';
import { Recommendation } from '../recommendation/recommendation.entity';

@Entity()
export class RecommendedCar {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Recommendation, (rec) => rec.recommendedCars, { onDelete: 'CASCADE' })
  recommendation: Recommendation;

  @ManyToOne(() => Car)
  car: Car; // The recommended car
}
