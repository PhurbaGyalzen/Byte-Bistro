import { Types } from 'mongoose'

export type IAuthenticatedUser = {
	id: Types.ObjectId
	username: string
	iat: number
	exp: number
}
