import { Router } from 'express'

import {
	getCart,
	viewCart,
	createCart,
	updateCart,
	deleteCart,
} from '../controller/cartController'

const router = Router()

router.get('/', viewCart)
router.get('/:cartId', getCart)
router.post('/', createCart)
router.put('/', updateCart)
router.delete('/:cartId', deleteCart)

export default router
