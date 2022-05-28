import { NextFunction, Request, Response } from 'express'

import { Category, Food } from '../models/Food'
import { Cart } from '@models/Cart'
import { IRequest } from '@mytypes/Request'
import { IAuthenticatedUser } from '@mytypes/Auth'

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
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const userCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.findOne({ userId: req.params.userId }).populate({
			path: 'items.foodId',
			select: 'name price image isAvailable',
		});
		res.status(200).json(cart);
	} catch (err) {
		res.status(400).json({ message: err });
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
			userId: req.user!.id,
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

export const addRemoveItem = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const { cartId, opType, items } = req.body
	let err: any
	try {
		if (opType === 'add') {
			const cart = await Cart.findByIdAndUpdate(cartId, {
				$push: {
					items: items,
				},
			})
			return res.status(200).json(cart)
		}
		if (opType === 'delete') {
			const foodIds = items.map((item: any) => item.foodId)
			const cart = await Cart.findByIdAndUpdate(cartId, {
				$pull: {
					items: {
						foodId: {
							$in: foodIds,
						},
					},
				},
			})
			return res.status(200).json(cart)
		}
		err = 'Invalid operation type'
	} catch (err) {}
	return res.status(400).json({ message: err })
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
