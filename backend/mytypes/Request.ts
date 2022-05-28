import { Request } from 'express'
import { IUser } from '@mytypes/Auth'

export interface IRequest extends Request {
	user: IUser
}
