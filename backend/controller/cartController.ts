import { NextFunction, Request, Response } from 'express'

import { Category, Food } from '../models/Food'
import { Cart } from '@models/Cart'

export const getCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.findById(req.params.cartId).populate({
			path: 'items.foodId',
			select: 'name price image isAvailable',
		})
		console.log(cart?.userId)
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const viewCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const carts = await Cart.find()
		res.status(200).json(carts)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const createCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = new Cart({
			userId: req.body.userId,
			items: req.body.items,
			tableId: req.body.tableId,
		})
		await cart.save()
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const updateCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.findByIdAndUpdate(req.params.cartId, req.body, {
			new: true, // should use this? if client uses PUT, they don't wanna create new docs(they'd use POST)
		})
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const deleteCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.findByIdAndDelete(req.params.cartId)
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}
