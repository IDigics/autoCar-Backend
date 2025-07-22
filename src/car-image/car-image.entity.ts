import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { Car } from '../car/car.entity';

@Entity()
export class CarImage {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  url: string;
  
  @Column({ type: 'enum', enum: ['main', 'secondary'], default: 'secondary' })
  type: 'main' | 'secondary';

  @ManyToOne(() => Car, (car) => car.images, { onDelete: 'CASCADE' })
  car: Car;
}
