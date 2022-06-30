import mongoose, { Document, Schema, Types } from 'mongoose'
import { IMenuItem } from './Food'

export interface ICart {
	userId: Types.ObjectId
	items: {
		foodId: Types.ObjectId
		qty: number
	}[]
	tableId: number
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
					required: true,
				},
				qty: {
					type: Number,
					required: true,
				},
			},
		],
		default: [],
	},
	tableId: {
		type: Number,
		required: true,
	},
}

const CartSchema = new mongoose.Schema<ICartDoc>(CartSchemaFields, {
	timestamps: true,
})
export const Cart = mongoose.model<ICartDoc>('Cart', CartSchema)
