import { Types } from 'mongoose'

export interface IUserInfoToSign {
	id: Types.ObjectId
	username: string
}

export interface IAuthenticatedUser extends IUserInfoToSign {
	iat: number
	exp: number
}
