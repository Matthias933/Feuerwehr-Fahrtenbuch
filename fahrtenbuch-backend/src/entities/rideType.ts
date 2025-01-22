import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class RideType {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;
}
