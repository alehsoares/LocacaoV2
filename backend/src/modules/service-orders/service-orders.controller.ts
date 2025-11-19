import { Controller, Get } from '@nestjs/common'

@Controller('service-orders')
export class ServiceOrdersController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}