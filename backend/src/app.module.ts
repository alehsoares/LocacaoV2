import { Module } from '@nestjs/common'
import { CoreModule } from './core/core.module'
import { SharedModule } from './shared/shared.module'
import { AuthModule } from './modules/auth/auth.module'
import { TenantsModule } from './modules/tenants/tenants.module'
import { PropertiesModule } from './modules/properties/properties.module'
import { PersonsModule } from './modules/persons/persons.module'
import { ContractsModule } from './modules/contracts/contracts.module'
import { ServiceOrdersModule } from './modules/service-orders/service-orders.module'

@Module({
  imports: [
    CoreModule,
    SharedModule,
    AuthModule,
    TenantsModule,
    PropertiesModule,
    PersonsModule,
    ContractsModule,
    ServiceOrdersModule,
  ],
})
export class AppModule {}