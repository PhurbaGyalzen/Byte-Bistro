import { Router } from 'express'
import { verifyUser } from 'middlewares/jwt-auth'

import {
	viewCart,
	createCart,
	updateCart,
	deleteCart,
	mostRecentUserCart,
	userCart,
	changeDuration,
} from '../controller/cartController'

const router = Router()

router.get('/', viewCart)
router.post('/', createCart)
router.patch('/:cartId', updateCart)
router.put('/', updateCart)
router.patch('/duration/:cartId', changeDuration)
// router.get('/user', userCart)
router.delete('/:cartId', deleteCart)
router.get('/user',verifyUser,userCart)
router.get('/user/incomplete',verifyUser,mostRecentUserCart)

export default router
