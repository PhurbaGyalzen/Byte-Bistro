import mongoose, { Document, Schema, Types } from 'mongoose'

export interface IFavourite{
    userId: Types.ObjectId
    foodId: Types.ObjectId
    createdAt: Date
    updatedAt: Date
}

const FavouriteSchemaFields: Record<keyof IFavourite, any> = {
    userId: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: 'User',
    },
    foodId: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: 'Food',
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    updatedAt: {
        type: Date,
        default: Date.now,
    }
};

const FavouriteSchema = new mongoose.Schema<IFavourite>(FavouriteSchemaFields, {
    timestamps: true,
});
export const Favourite = mongoose.model<IFavourite>('Favourite', FavouriteSchema)

