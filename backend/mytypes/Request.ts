import { Request } from 'express'
import { IAuthenticatedUser } from '@mytypes/Auth'

export interface IRequest extends Request {
	user: IAuthenticatedUser
}
