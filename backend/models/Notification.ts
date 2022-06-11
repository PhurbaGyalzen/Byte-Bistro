import mongoose, { Document, Schema, Types } from 'mongoose'

export interface INotification {
    userId: Types.ObjectId
    message: string
    read: boolean
    isOffer: boolean
    image : string
    createdAt: Date
    updatedAt: Date
}

const NotificationSchemaFields: Record<keyof INotification, any> = {
    userId: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: 'User',
    },
    message: {
        type: String,
        required: true,
    },
    read: {
        type: Boolean,
        required: true,
        default: false,
    },
    isOffer: {
        type: Boolean,
        required: true,
        default: false,
    },
    image:{
        type: String,
        required: false,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    updatedAt: {
        type: Date,
        default: Date.now,
    }
}


const NotificationSchema = new mongoose.Schema<INotification>(NotificationSchemaFields, {
    timestamps: true,
});
export const Notification = mongoose.model<INotification>('Notification', NotificationSchema)
