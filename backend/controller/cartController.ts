import { NextFunction, Request, Response } from 'express'

import { Cart, CartStatus } from '@models/Cart'
import { errorMonitor } from 'events'
import { IOType } from 'child_process'

export const getCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.findById(req.params.cartId)
			.populate({
				path: 'items.foodId',
				select: 'name price image isAvailable',
			})
			.populate({
				path: 'userId',
				select: 'fullname',
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
		const cart = await Cart.find({ userId: req.user?.id,status:{$eq:3}}).sort({createdAt: -1}).populate({
			path: 'items.foodId',
			select: 'name price image isAvailable',
		})
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const mostRecentUserCart = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const cart = await Cart.find({ userId: req.user!.id}).sort({createdAt: -1}).limit(1).populate({
			path: 'items.foodId',
			select: 'name price image isAvailable',
		}).populate({
			path: 'userId',
			select: 'fullname',
		})
		if (cart.length > 0) {
			res.status(200).json(cart[0])
		}
		else {
			res.status(400).json({success: false, message: 'No order found for this user.'})
		}
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
		const carts = await Cart.find().populate({
			path: 'userId',
			select: 'fullname',
		}).populate({
			path: 'items.foodId',
			select: 'name price image isAvailable',
		}).sort({createdAt: -1})
		res.status(200).json(carts)
	} catch (err) {
		res.status(400).send(err)
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
			paymentMethod: req.body.paymentMethod,
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

type IOpType = {
	$inc: IOpType
} | {
	duration: number
}

/* increment, decrement, or direct change duration */
export const changeDuration = async(
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const {opType, value} = req.body
	let fieldUpdateQuery: IOpType = {
		duration: value
	}
	
	if (opType === 'inc') {
		fieldUpdateQuery = {$inc: fieldUpdateQuery}
	} else if (opType === 'dec') {
		fieldUpdateQuery = {$inc: {...fieldUpdateQuery, duration: -value}}
	}
	try {
		const cart = await Cart.findByIdAndUpdate(req.params.cartId, fieldUpdateQuery)
		res.status(200).json(cart)
	} catch (err) {
		res.status(400).json({success: false, message: err})
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
