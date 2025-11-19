import { Controller, Get } from '@nestjs/common'

@Controller('auth')
export class AuthController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}