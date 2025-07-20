import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { Car } from '../car/car.entity';

@Entity()
export class Review {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Car, (car) => car.reviews, { onDelete: 'CASCADE' })
  car: Car;

  @Column()
  email: string;

  @Column('int')
  score: number;

  @Column()
  comment: string;
}
