import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Person } from './entities/person';
import { Admin } from 'typeorm';
import { Account } from './entities/account';

@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}


  @Get('signIn')
  async signIn(@Query('name') name: string, @Query('password') password: string): Promise<string> {
    return this.authService.signIn(name, password);
  }

  @Get('createAdminAccount')
  doBootstrap(): Promise<Account> {
    return this.authService.bootstrap();
  }
}
