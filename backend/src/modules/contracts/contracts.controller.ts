import { Controller, Get } from '@nestjs/common'

@Controller('contracts')
export class ContractsController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}