import { Controller, Get } from '@nestjs/common'

@Controller('properties')
export class PropertiesController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}