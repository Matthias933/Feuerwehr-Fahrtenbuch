import { Controller, Get, UseGuards, Request, Post, Body, Delete, Param, Put } from '@nestjs/common';
import { AppService } from './app.service';
import { Person } from './entities/person';
import { Ride } from './entities/ride';
import { get } from 'http';
import { create } from 'domain';
import { JwtAuthGuard } from './jwt.auth.guard';
import { Car } from './entities/car';
import { RideDto } from './entities/rideDto';
import { Role } from './entities/role';
import { RideType } from './entities/rideType';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}


  @UseGuards(JwtAuthGuard)
  @Get('rideTypes')
  getRideTypes(): Promise<RideType[]> {
    return this.appService.getRideTypes();
  }

  //used for managment app
  @UseGuards(JwtAuthGuard)
  @Get('people')
  getPeople(): Promise<Person[]> {
    return this.appService.getPeople(false);
  }

  //used for client app
  @UseGuards(JwtAuthGuard)
  @Get('activePeople')
  getActivePeople(): Promise<Person[]> {
    return this.appService.getPeople(true);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('people/:id') 
  deletePeople(@Param('id') id: number): Promise<void> {
    return this.appService.deletePerson(id); 
  }

  @UseGuards(JwtAuthGuard)
  @Put('people')
  async editPeople(@Body() person: Person): Promise<void> {
    await this.appService.editPerson(person);
  }

  @UseGuards(JwtAuthGuard)
  @Post('people')
  async postPeople(@Body() person: Person): Promise<void> {
    await this.appService.createPerson(person);
  }

  @UseGuards(JwtAuthGuard)
  @Post('ride')
  postRide(@Body() createRideDto: RideDto): Promise<Ride>{
    return this.appService.postRide(createRideDto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('ride')
  getRide(): Promise<Ride[]>{
    return this.appService.getRide();
  }

  @UseGuards(JwtAuthGuard)
  @Put('ride')
  async editRide(@Body() ride: RideDto): Promise<void> {
    await this.appService.editRide(ride);
  }

  @UseGuards(JwtAuthGuard)
  @Get('car')
  getCar(): Promise<Car[]>{
    return this.appService.getCar(false);
  }

  @UseGuards(JwtAuthGuard)
  @Get('activeCar')
  getActiveCars(): Promise<Car[]>{
    return this.appService.getCar(true);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('car/:id') 
  deleteCar(@Param('id') id: number): Promise<void> {
    return this.appService.deleteCar(id); 
  }

  @UseGuards(JwtAuthGuard)
  @Put('car')
  async editCar(@Body() car: Car): Promise<void> {
    await this.appService.editCar(car);
  }

  @UseGuards(JwtAuthGuard)
  @Post('car')
  async postCar(@Body() car: Car): Promise<void> {
    await this.appService.createCar(car);
  }

  @Get('bootstrap')
  doBootstrap(): Promise<Person[]> {
    return this.appService.bootstrap();
  }

  @Get('bootstrapCar')
  doBootstrapCar(): Promise<Car[]> {
    return this.appService.carBootstrap();
  }

  @Get('bootstrapRideType')
  doBootstrapRideType(): Promise<RideType[]> {
    return this.appService.rideTypeBootstrap();
  }

  @Get('roleBootstrap')
  roleBootstrap(): Promise<Role[]>{
    return this.appService.roleBootstrap();
  }

  @Post('checkConnection')
  checkConnection(){}
}
