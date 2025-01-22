import {
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  Column
} from 'typeorm';
import { Role } from './role';
import { Person } from './person';
import { Car } from './car';
import { RideType } from './rideType';

@Entity()
export class Ride {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Person, {onDelete: 'CASCADE'})
  driver: Person;

  @ManyToOne(() => Person, {onDelete: 'CASCADE'})
  commander: Person;

  @ManyToOne(() => RideType)
  rideType: RideType;

  @ManyToOne(() => Car, (car) => car.rides, {onDelete: 'CASCADE'})
  car: Car;

  @Column()
  date: string
  
  @Column()
  rideDescription: string;

  @Column()
  kilometerStart: number;

  @Column()
  kilometerEnd: number;

  @Column({ nullable: true })
  gasLiter: number;

  @Column({ default: true })
  usedPowerGenerator: boolean;

  @Column({ default: true })
  powerGeneratorTankFull: boolean;

  @Column({ default: true })
  usedRespiratoryProtection: boolean;

  @Column({ default: true })
  respiratoryProtectionUpgraded: boolean;

  @Column({ default: true })
  usedCAFS: boolean;

  @Column({ default: true })
  cafsTankFull: boolean;

  @Column({ nullable: true })
  defects: string;

  @Column({ nullable: true })
  missingItems: string;
}
