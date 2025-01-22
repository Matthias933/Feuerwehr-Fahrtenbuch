import { Injectable } from '@nestjs/common';
import { Person } from './entities/person';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Role } from './entities/role';
import { Ride } from './entities/ride';
import { identity } from 'rxjs';
import { Car } from './entities/car';
import internal from 'stream';
import { RideDto } from './entities/rideDto';
import { RideType } from './entities/rideType';

@Injectable()
export class AppService {
  constructor(
    @InjectRepository(Person)
    private personRepository: Repository<Person>,
    @InjectRepository(Role)
    private roleRepository: Repository<Role>,
    @InjectRepository(Ride)
    private rideRepository: Repository<Ride>,
    @InjectRepository(Car)
    private carRepository: Repository<Car>,
    @InjectRepository(RideType)
    private rideTypeRepository: Repository<RideType>
  ) {}

  getPeople(filter: boolean): Promise<Person[]> {
    if(filter){
      return this.personRepository.find({where: {isActive: true}, relations: { roles: true } });
    }
    return this.personRepository.find({relations: {roles: true}});
  }

  async deletePerson(id: number): Promise<void> {
    await this.personRepository.delete(id);
  }

  async editPerson(person: Person): Promise<void> {
    const existingPerson = await this.personRepository.findOne({
      where: { id: person.id },
      relations: ['roles'],
    });
  
    if (!existingPerson) {
      throw new Error('Person not found');
    }
  
    existingPerson.firstName = person.firstName;
    existingPerson.lastName = person.lastName;
    existingPerson.isActive = person.isActive;
  
    const roleNames = person.roles.map(role => role.name);
  
    const roles = await this.roleRepository.find({
      where: {
        name: In(roleNames),
      },
    });
  
    existingPerson.roles = roles;
  
    await this.personRepository.save(existingPerson);
  }
  

  async createPerson(person: Person): Promise<void> {
    
    const roleNames = person.roles.map(role => role.name); 
    console.log('----------------------------' + roleNames[0]);
    const roles = await this.roleRepository.find({
      where: {
        name: In(roleNames),  
      },
    });
    console.log('---------------------------' + roles.length);
    person.roles = roles;
    await this.personRepository.save(person);
  }
   
  getRideTypes(): Promise<RideType[]>{
    return this.rideTypeRepository.find();
  }

  getCar(filter: boolean): Promise<Car[]>{
    if(filter){
      return this.carRepository.find({where: {isActive: true}})
    }
    return this.carRepository.find();
  }

  async deleteCar(id: number): Promise<void> {
    await this.carRepository.delete(id);
  }

  async editCar(car: Car): Promise<void> {
    const existingCar = await this.carRepository.findOne({where: { id: car.id }});
  
    if (!existingCar) {
      throw new Error('Car not found');
    }
  
    existingCar.carNumber = car.carNumber;
    existingCar.buildyear = car.buildyear;
    existingCar.isActive = car.isActive;
    existingCar.manufacturer = car.manufacturer;
    existingCar.type = car.type;
  
    await this.carRepository.save(existingCar);
  }
  

  async createCar(car: Car): Promise<void> {
    await this.carRepository.save(car);
  }

  getRide(): Promise<Ride[]> {
    return this.rideRepository.find({relations: {rideType: true, driver: {roles: true}, commander: {roles: true}, car: true}});
  }

  async postRide(createRideDto: RideDto): Promise<Ride> {
    const driver = await this.personRepository.findOne({ where: { id: createRideDto.driverId } });
    const commander = await this.personRepository.findOne({ where: { id: createRideDto.commanderId } });
    const car = await this.carRepository.findOne({where: {id: createRideDto.carId}});
    const rideType = await this.rideTypeRepository.findOne({where:{id: createRideDto.rideTypeId}});
    if (!driver || !commander) {
      throw new Error('Driver or Commander not found');
    }
  
    const ride = new Ride();
    ride.car = car;
    ride.driver = driver;
    ride.commander = commander;
    ride.rideType = rideType;
    ride.date = createRideDto.date;
    ride.rideDescription = createRideDto.rideDescription;
    ride.kilometerStart = createRideDto.kilometerStart;
    ride.kilometerEnd = createRideDto.kilometerEnd;
    ride.gasLiter = createRideDto.gasLiter;
    ride.usedPowerGenerator = createRideDto.usedPowerGenerator;
    ride.powerGeneratorTankFull = createRideDto.powerGeneratorTankFull;
    ride.usedRespiratoryProtection = createRideDto.usedRespiratoryProtection;
    ride.respiratoryProtectionUpgraded = createRideDto.respiratoryProtectionUpgraded;
    ride.usedCAFS = createRideDto.usedCAFS;
    ride.cafsTankFull = createRideDto.cafsTankFull;
    ride.defects = createRideDto.defects;
    ride.missingItems = createRideDto.missingItems;
  
    return await this.rideRepository.save(ride);
  }

  async editRide(ride: RideDto): Promise<void> {
    const existingRide = await this.rideRepository.findOne({where: { id: ride.id }});
  
    if (!existingRide) {
      throw new Error('ride not found');
    }
  
    const driver = await this.personRepository.findOne({ where: { id: ride.driverId } });
    const commander = await this.personRepository.findOne({ where: { id: ride.commanderId } });
    const car = await this.carRepository.findOne({where: {id: ride.carId}});
    const rideType = await this.rideTypeRepository.findOne({where:{id: ride.rideTypeId}});
    if (!driver || !commander) {
      throw new Error('Driver or Commander not found');
    }
  
    existingRide.car = car;
    existingRide.driver = driver;
    existingRide.commander = commander;
    existingRide.rideType = rideType;
    existingRide.date = ride.date;
    existingRide.rideDescription = ride.rideDescription;
    existingRide.kilometerStart = ride.kilometerStart;
    existingRide.kilometerEnd = ride.kilometerEnd;
    existingRide.gasLiter = ride.gasLiter;
    existingRide.usedPowerGenerator = ride.usedPowerGenerator;
    existingRide.powerGeneratorTankFull = ride.powerGeneratorTankFull;
    existingRide.usedRespiratoryProtection = ride.usedRespiratoryProtection;
    existingRide.respiratoryProtectionUpgraded = ride.respiratoryProtectionUpgraded;
    existingRide.usedCAFS = ride.usedCAFS;
    existingRide.cafsTankFull = ride.cafsTankFull;
    existingRide.defects = ride.defects;
    existingRide.missingItems = ride.missingItems;
  
    await this.rideRepository.save(existingRide);
  }

  async rideTypeBootstrap(): Promise<RideType[]>{
    const type1 = {
      id: 1,
      name: 'Einsatz'
    }
    const type2 = {
      id: 2,
      name: 'Übung'
    }
    const type3 = {
      id: 3,
      name: 'Bewegungsfahrt'
    }
    const type4 = {
      id: 4,
      name: 'Sonstiges'
    }
    await this.rideTypeRepository.save(type1);
    await this.rideTypeRepository.save(type2);
    await this.rideTypeRepository.save(type3);
    await this.rideTypeRepository.save(type4);
    return null;
  }
  
  async carBootstrap(): Promise<Car[]> {
    const c1 = {
      carNumber: 'Fahrzeug 1',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };
    const c2 = {
      carNumber: 'Fahrzeug 2',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };
    const c3 = {
      carNumber: 'Fahrzeug 3',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };
    const c4 = {
      carNumber: 'Fahrzeug 4',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };
    const c5 = {
      carNumber: 'Fahrzeug 5',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };
    const c6 = {
      carNumber: 'Fahrzeug 6',
      manufacturer: 'Default manufacturer',
      type: 'default type',
      buildyear: 2006,
      isActive: true
    };

    this.carRepository.save(c1);
    this.carRepository.save(c2);
    this.carRepository.save(c3);
    this.carRepository.save(c4);
    this.carRepository.save(c5);
    this.carRepository.save(c6);
    return null;
  }

  async roleBootstrap(): Promise<Role[]>{
    const role1 = { id: 1, name: 'Maschinist' };
    const role2 = { id: 2, name: 'Kommandant' };
    await this.roleRepository.save(role1);
    await this.roleRepository.save(role2);
    return null;
  }

  async bootstrap(): Promise<Person[]> {
    const role1 = { id: 1, name: 'Maschinist' };
    const role2 = { id: 2, name: 'Kommandant' };
    const p1 = {
      firstName: 'Matthias',
      lastName: 'Braun',
      isActive: true,
      roles: [role1],
    };
    const p2 = {
      firstName: 'Sophia',
      lastName: 'Meyer',
      isActive: false,
      roles: [role1, role2],
    };

    const p3 = {
      firstName: 'John',
      lastName: 'Doe',
      isActive: true,
      roles: [role1],
    };

    const p4 = {
      firstName: 'Emily',
      lastName: 'Johnson',
      isActive: true,
      roles: [role1, role2],
    };

    const p5 = {
      firstName: 'Lucas',
      lastName: 'Smith',
      isActive: false,
      roles: [role2],
    };

    const p6 = {
      firstName: 'Olivia',
      lastName: 'Brown',
      isActive: true,
      roles: [role2],
    };

    const p7 = {
      firstName: 'Liam',
      lastName: 'Taylor',
      isActive: false,
      roles: [role1],
    };

    const p8 = {
      firstName: 'Isabella',
      lastName: 'Davis',
      isActive: true,
      roles: [role1, role2],
    };
    await this.roleRepository.save(role1);
    await this.roleRepository.save(role2);
    this.personRepository.save(p1);
    this.personRepository.save(p2);
    this.personRepository.save(p3);
    this.personRepository.save(p4);
    this.personRepository.save(p5);
    this.personRepository.save(p6);
    this.personRepository.save(p7);
    this.personRepository.save(p8);
    return null;
  }
}
