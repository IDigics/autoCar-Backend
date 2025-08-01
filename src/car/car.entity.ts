import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
} from 'typeorm';
import { Brand } from '../brand/brand.entity';
import { Category } from '../category/category.entity';
import { SubCategory } from '../sub-category/sub-category.entity';
import { FuelType } from '../fuel-type/fuel-type.entity';
import { CarImage } from '../car-image/car-image.entity';
import { Review } from '../review/review.entity'
import { Recommendation } from '../recommendation/recommendation.entity';

@Entity()
export class Car {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  mileage: number;  

 @ManyToOne(() => Brand, (brand) => brand.cars, {eager: true,nullable: true,onDelete: 'SET NULL',})
  brand: Brand;

  @Column()
  model: string;

  @ManyToOne(() => FuelType, (fuel) => fuel.cars, {eager: true,nullable: true,onDelete: 'SET NULL',})
  fuelType: FuelType;

  @Column({ type: 'enum', enum: ['Automatic', 'Manual'],default:'Manual'})
  gear: 'Automatic'| 'Manual';

  @Column({ type: 'enum', enum: ['new', 'used'],default:"new"})
  offerType:'new'| 'used';

  @Column('int')
  price: number;

  @Column('int')
  horsePower: number;

  @Column()
  year: number;

  @Column('float')
  engineSize: number;

  @Column()
  doors: number;

  @Column()
  seats: number;

  @Column({ nullable: true })
  previousOwner: number;

  @Column()
  color: string;

  @Column({ type: 'float', default: 0 })
  averageReviewScore: number;


  @ManyToOne(() => Category, (cat) => cat.cars, {eager: true,nullable: true,onDelete: 'SET NULL',})
  category: Category;

  @ManyToOne(() => SubCategory, (sub) => sub.cars, {eager: true,nullable: true,onDelete: 'SET NULL',})
  subCategory: SubCategory;

  @OneToMany(() => CarImage, (image) => image.car, { cascade: true })
  images: CarImage[];

  @OneToMany(() => Review, (rev) => rev.car)
  reviews: Review[];

  @OneToMany(() => Recommendation, (rec) => rec.car)
  recommendations: Recommendation[];
}

