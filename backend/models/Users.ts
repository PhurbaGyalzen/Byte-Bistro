import mongoose, { Document, Schema, Types } from 'mongoose'

export interface IUser {
    username: string
    passwordHash: string
    email: string
    fullname: string
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
}

const UserSchema = new mongoose.Schema<IUserDoc>(UserSchemaFields, {
    timestamps: true,
})

export const User = mongoose.model<IUserDoc>('User', UserSchema)
