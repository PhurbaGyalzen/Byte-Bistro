import { Request, Response, NextFunction } from 'express'
import { Category, Food } from '../models/Food'

// controller for viewing single food
export const getFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const food = await Food.findById(req.params.foodId)
		res.status(200).json(food)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

// controller for viewing all food
export const viewFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const foods = await Food.find()
		res.status(200).json(foods)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

// controller to add food
export const putFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const { name, price, description, image, categoriyIds } = req.body
	try {
		const food = new Food({
			name: name,
			price: price,
			description: description,
			image: image,
			categories: categoriyIds || [],
			// image: images,
		})
		await food.save()
		res.status(200).json(food)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

// controller to update single food
export const updateFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const { name, price, description, image } = req.body
	try {
		const food = await Food.updateOne(
			{ _id: req.params.foodId },
			{
				$set: {
					name: req.body.name,
					price: req.body.price,
					description: req.body.description,
					// image:req.body.image
				},
			}
		)
		res.status(200).json(food)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

// controller to delete single food
export const deleteFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const food = await Food.remove({ _id: req.params.foodId })
		res.status(200).json(food)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const addCategory = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const { name } = req.body
	try {
		const category = new Category({
			name: name,
		})
		await category.save()
		res.status(200).json(category)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}
