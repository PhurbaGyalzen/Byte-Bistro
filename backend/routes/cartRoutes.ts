import { Router } from 'express'
import { verifyUser } from 'middlewares/jwt-auth'

import {
	getCart,
	viewCart,
	createCart,
	updateCart,
	deleteCart,
	addRemoveItem,
	userIncompleteCart,
	userCart,
} from '../controller/cartController'

const router = Router()

router.get('/', viewCart)
router.post('/', createCart)
router.patch('/:cartId', updateCart)
router.put('/', updateCart)
// router.get('/user', userCart)
router.delete('/:cartId', deleteCart)
router.get('/user',verifyUser,userCart)
router.get('/user/incomplete',verifyUser,userIncompleteCart)

export default router
