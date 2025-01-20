import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Person } from './entities/person';
import { Role } from './entities/role';
import { Account } from './entities/account';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from './jwt.strategy';
import { JwtAuthGuard } from './jwt.auth.guard';
import { Ride } from './entities/ride';
import { Car } from './entities/car';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: `./data/line.sqlite`,
      entities: [Person, Role, Account, Ride, Car],
      synchronize: true,
      logging: 'all',
    }),
    JwtModule.register({
      secret: 'mysecretkey', 
      signOptions: { expiresIn: '1h' },
    }),
    TypeOrmModule.forFeature([Person, Role, Account, Ride, Car]),
  ],
  controllers: [AppController, AuthController],
  providers: [AppService, AuthService, JwtStrategy, JwtAuthGuard],
})
export class AppModule {}
