import { Router } from 'express'
import { verifyUser } from 'middlewares/jwt-auth'

import {
	getCart,
	viewCart,
	createCart,
	updateCart,
	deleteCart,
	addRemoveItem,
} from '../controller/cartController'

const router = Router()

router.get('/', viewCart)
router.get('/:cartId', getCart)
router.post('/', verifyUser, createCart)
router.patch('/', addRemoveItem)
router.put('/', updateCart)
router.delete('/:cartId', deleteCart)

export default router
