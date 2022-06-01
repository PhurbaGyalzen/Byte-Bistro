import mongoose, { Document, Schema, Types } from 'mongoose'

interface FoodRating extends Document {
	id: number
	foodId: number
	userId: number
	rating: number
}

interface FoodReview extends Document {
	id: number
	foodId: number
	userId: number
	review: string
}

interface FoodOrder extends Document {
	id: number
	foodId: number
	userId: number
	quantity: number
}

interface FoodOrderHistory extends Document {
	id: number
	foodId: number
	userId: number
	quantity: number
	date: Date
}

interface Bookmark extends Document {
	id: number
	userId: number
	foodId: number
}

interface INutrition {
	calories: number
	fat: number
	carbs: number
	protein: number
}

interface ICategory {
	name: string
}

export interface IMenuItem {
	name: string
	price: number
	image: string
	isAvailable: boolean
}

interface IFoodCart extends IMenuItem {
	qty: number
}

export interface IFood extends IMenuItem {
	description: string
	categories: ICategory[]
	avgRating: number
	avgPrepTime: number
	ingredients: string[]
	nutrition: INutrition
}

interface IFoodDoc extends IFood, Document {}

const FoodSchemaFields: Record<keyof IFood, any> = {
	name: { type: String, required: true, minlength: 1, maxlength: 255 },
	price: { type: Number, required: true },
	description: { type: String, minlength: 0, maxlength: 1024 },
	image: { type: String, required: true },
	categories: { ref: 'Category', type: [Schema.Types.ObjectId], default: [] },
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
}

const FoodSchema = new Schema<IFoodDoc>(FoodSchemaFields, { timestamps: true })



interface ICategoryDoc extends ICategory, Document {}

const CategorySchemaFields: Record<keyof ICategory, any> = {
	name: {
		type: String,
		required: true,
		minlength: 1,
		maxlength: 255,
		index: true,
	},
}

const CategorySchema = new mongoose.Schema<ICategoryDoc>(CategorySchemaFields)

export const Category = mongoose.model<ICategoryDoc>('Category', CategorySchema)
export const Food = mongoose.model<IFoodDoc>('Food', FoodSchema)

