import { IAuthenticatedUser } from '@mytypes/Auth'

export {}

declare global {
	namespace Express {
		export interface Request {
			user: User
		}
		export interface User extends IAuthenticatedUser {}
	}
}
