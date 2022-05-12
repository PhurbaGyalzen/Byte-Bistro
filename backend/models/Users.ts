import mongoose, { Document, Schema, Types } from 'mongoose'

export interface IUser {
    username: string
    passwordHash: string
    email: string
    fullname: string
    phones: string[]
    address: string
    avatar: string
    isAdmin: boolean
    bio: string
}
interface IUserDoc extends IUser, Document {}

const UserSchemaFields: Record<keyof IUser, any> = {
    username: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 30,
    },
    passwordHash: {
        type: String,
        required: true,
        minlength: 8,
        maxlength: 1024,
    },
    email: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 255,
        unique: true,
    },
    fullname: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 255,
    },
    phones: {
        type: [String],
        minlength: 1,
        maxlength: 20,
    },
    address: {
        type: String,
        minlength: 1,
        maxLength: 150,
    },
    avatar: {
        type: String,
    },
    bio: {
        type: String,
        minlength: 0,
        maxlength: 255,
        default: '',
    },
    isAdmin: {
        type: Boolean,
        default: false,
    },
}

const UserSchema = new mongoose.Schema<IUserDoc>(UserSchemaFields, {
    timestamps: true,
})

export const User = mongoose.model<IUserDoc>('User', UserSchema)
