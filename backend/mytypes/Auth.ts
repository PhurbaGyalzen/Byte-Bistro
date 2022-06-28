import { Types } from 'mongoose'

export interface IUserInfoToSign {
	id: Types.ObjectId
	username: string
	isAdmin: boolean
}

export interface IAuthenticatedUser extends IUserInfoToSign {
	iat: number
	exp: number
}
