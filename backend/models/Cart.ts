import mongoose, { Document, Schema, Types } from 'mongoose';

export enum CartStatus {
  Pending = 0,
  Preping = 1,
  Ready = 2,
  Completed = 3,
}

export interface ICart {
	userId: Types.ObjectId
	items: {
		foodId: Types.ObjectId
		qty: number
	}[]
	tableId: number
  status: CartStatus
  paymentMethod: string
  duration: number
}

interface ICartDoc extends ICart, Document {
  createdAt: Date
  updatedAt: Date
}

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
  paymentMethod : {
    type: String,
    required: true,
  },
  status: {
    type: Number,
    required: true,
    default: CartStatus.Pending,
    min: CartStatus.Pending,
    max: CartStatus.Completed,
  },
  duration: {
    type: Number,
    required: false,
    min: 0,
    default: 25
  }
};

const CartSchema = new mongoose.Schema<ICartDoc>(CartSchemaFields, {
  timestamps: true,
});
export const Cart = mongoose.model<ICartDoc>('Cart', CartSchema);
