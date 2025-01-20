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

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @UseGuards(JwtAuthGuard)
  @Get('people')
  getPeople(): Promise<Person[]> {
    return this.appService.getPeople();
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
  @Delete('ride/:id') 
  deleteRide(@Param('id') id: number): Promise<void> {
    return this.appService.deleteRide(id); 
  }

  @UseGuards(JwtAuthGuard)
  @Put('ride')
  async editRide(@Body() ride: RideDto): Promise<void> {
    await this.appService.editRide(ride);
  }

  @UseGuards(JwtAuthGuard)
  @Get('car')
  getCar(): Promise<Car[]>{
    return this.appService.getCar();
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

  @UseGuards(JwtAuthGuard)
  @Get('bootstrap')
  doBootstrap(): Promise<Person[]> {
    return this.appService.bootstrap();
  }

  @UseGuards(JwtAuthGuard)
  @Get('bootstrapCar')
  doBootstrapCar(): Promise<Car[]> {
    return this.appService.carBootstrap();
  }

  @Get('roleBootstrap')
  roleBootstrap(): Promise<Role[]>{
    return this.appService.roleBootstrap();
  }

  @Post('checkConnection')
  checkConnection(){
    
  }
}
