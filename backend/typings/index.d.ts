import { IAuthenticatedUser } from '@mytypes/Auth'

export {}

declare global {
	namespace Express {
		export interface User extends IAuthenticatedUser {}
	}
}
