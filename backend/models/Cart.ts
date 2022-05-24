import mongoose, { Document, Schema, Types } from 'mongoose'
import { IMenuItem } from './Food'

export interface ICart {
	userId: Types.ObjectId
	items: {
		foodId: IMenuItem
		qty: number
	}[]
	tableId: Types.ObjectId
}

interface ICartDoc extends ICart, Document {}

const CartSchemaFields: Record<keyof ICart, any> = {
	userId: {
		type: Schema.Types.ObjectId,
		required: true,
		ref: 'User',
	},
	items: {
		type: [
			{
				foodId: {
					type: Schema.Types.ObjectId,
					ref: 'Food',
					populate: {
						select: 'name price image isAvailable',
					},
				},
				qty: {
					type: Number,
				},
			},
		],
		default: [],
	},
	tableId: {
		type: Number,
	},
}

const CartSchema = new mongoose.Schema<ICartDoc>(CartSchemaFields, {
	timestamps: true,
})
export const Cart = mongoose.model<ICartDoc>('Cart', CartSchema)
