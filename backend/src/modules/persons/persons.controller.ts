import { Controller, Get } from '@nestjs/common'

@Controller('persons')
export class PersonsController {
  @Get('admin/test')
  adminTest(): { status: string } {
    return { status: 'ok' }
  }
}