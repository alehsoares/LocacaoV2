import { AuthController } from '../src/modules/auth/auth.controller'

describe('Smoke tests', () => {
  it('Auth admin test returns ok', () => {
    const controller = new AuthController()
    const res = controller.adminTest()
    expect(res).toEqual({ status: 'ok' })
  })
})