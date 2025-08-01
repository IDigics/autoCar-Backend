import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { Car } from '../car/car.entity';

@Entity()
export class Brand {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  name: string;

  @Column({ nullable: true })
  logo: string;

  @OneToMany(() => Car, (car) => car.brand)
  cars: Car[];
}