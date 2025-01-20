import { Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Account } from './entities/account';
import { JwtService } from '@nestjs/jwt'; 
import * as crypto from 'crypto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Account)
    private accountRepository: Repository<Account>,
    private readonly jwtService: JwtService,
  ) {}

  async signIn(name: string, password: string): Promise<string> {
    const account = await this.accountRepository.findOne({
      where: { name },
    });

    if (!account || account.password !== password) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Generate a JWT token
    const claims = { username: account.name, sub: account.id};
    const token = this.jwtService.sign(claims);

    return token;
  }

  async bootstrap(): Promise<Account> {
    const p1 = {
      name: 'Admin',
      password: 'Admin',
    };
    await this.accountRepository.save(p1);
    return null;
  }
}
