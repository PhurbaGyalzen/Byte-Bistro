import { Router } from 'express'
import { verifyUser } from 'middlewares/jwt-auth'

import {
	getCart,
	viewCart,
	createCart,
	updateCart,
	deleteCart,
	addRemoveItem,
	userCart,
} from '../controller/cartController'

const router = Router()

router.get('/', viewCart)
router.post('/', createCart)
router.patch('/', addRemoveItem)
router.put('/', updateCart)
// router.get('/user', userCart)
router.delete('/:cartId', deleteCart)
router.get('/user',verifyUser,userCart)

export default router
