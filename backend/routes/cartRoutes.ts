import { Router } from 'express'

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
router.post('/', createCart)
router.patch('/', addRemoveItem)
router.put('/', updateCart)
router.delete('/:cartId', deleteCart)

export default router
