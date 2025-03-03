import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { JwtAuthGuard } from './jwt.auth.guard';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {cors: true});
  await app.listen(process.env.PORT ?? 3000);
  
  app.enableCors();
  app.useGlobalGuards(new JwtAuthGuard());
}
bootstrap();
