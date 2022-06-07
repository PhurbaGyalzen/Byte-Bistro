import mongoose, { Document, Schema, Types } from 'mongoose'

export interface INotification {
    userId: Types.ObjectId
    message: string
    read: boolean
    type: string
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
    type: {
        type: String,
        required: true,
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
