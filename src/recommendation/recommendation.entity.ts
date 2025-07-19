import {Entity,PrimaryGeneratedColumn,Column,ManyToOne,OneToMany,} from 'typeorm';
import { Car } from '../car/car.entity';
import { RecommendedCar } from '../recommended-car/recommended-car.entity'

@Entity()
export class Recommendation {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Car, { onDelete: 'CASCADE' })
  car: Car; // The main car being recommended for

  @Column()
  date: Date;

  @OneToMany(() => RecommendedCar, (rc) => rc.recommendation, { cascade: true })
  recommendedCars: RecommendedCar[];
}
