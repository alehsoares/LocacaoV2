import { Controller, Get } from '@nestjs/common'

@Controller('tenants')
export class TenantsController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}