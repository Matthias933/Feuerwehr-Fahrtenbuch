import {
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  Column,
  OneToMany,
  JoinTable,
} from 'typeorm';
import { Role } from './role';
import { Person } from './person';
import { Ride } from './ride';

@Entity()
export class Car {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  carNumber: String;

  @OneToMany(() => Ride, (ride) => ride.car)
  rides: Ride[];
}
