import mongoose, { Document, Schema, Types } from 'mongoose';
import { IUser } from './Users';

interface FoodRating extends Document {
  id: number;
  foodId: number;
  userId: number;
  rating: number;
}

interface FoodReview extends Document {
  id: number;
  foodId: number;
  userId: number;
  review: string;
}

interface FoodOrder extends Document {
  id: number;
  foodId: number;
  userId: number;
  quantity: number;
}

interface FoodOrderHistory extends Document {
  id: number;
  foodId: number;
  userId: number;
  quantity: number;
  date: Date;
}

interface Bookmark extends Document {
  id: number;
  userId: number;
  foodId: number;
}

interface INutrition {
  calories: number;
  fat: number;
  carbs: number;
  protein: number;
}

export interface IMenuItem {
  name: string;
  price: number;
  image: string;
  isAvailable: boolean;
}

interface IFoodCart extends IMenuItem {
  qty: number;
}

export interface IFood extends IMenuItem {
  description: string;
  categories: string[];
  avgRating: number;
  avgPrepTime: number;
  ingredients: string[];
  nutrition: INutrition;
}

interface IFoodDoc extends IFood, Document {}

const FoodSchemaFields: Record<keyof IFood, any> = {
  name: { type: String, required: true, minlength: 1, maxlength: 255 },
  price: { type: Number, required: true },
  description: { type: String, minlength: 0, maxlength: 1024 },
  image: { type: String, required: true },
  categories: { type: [String] },
  isAvailable: { type: Boolean, default: true },
  avgRating: { type: Number },
  avgPrepTime: { type: Number },
  ingredients: { type: [String] },
  nutrition: {
    calories: { type: Number },
    fat: { type: Number },
    carbs: { type: Number },
    protein: { type: Number },
  },
};

const FoodSchema = new Schema<IFoodDoc>(FoodSchemaFields, { timestamps: true });

export interface ICart {
  userId: Types.ObjectId;
  items: {
    foodId: IMenuItem;
    qty: number;
  }[];
  tableId: Types.ObjectId;
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
    type: Schema.Types.ObjectId,
  },
};

const CartSchema = new mongoose.Schema<ICartDoc>(CartSchemaFields, {
  timestamps: true,
});

export const Food = mongoose.model<IFoodDoc>('Food', FoodSchema);
export const Cart = mongoose.model<ICartDoc>('Cart', CartSchema);
