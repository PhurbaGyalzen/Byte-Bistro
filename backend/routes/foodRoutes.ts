import { Router } from 'express'
import {
	deleteFood,
	getFood,
	putFood,
	setAvailable,
	setUnavailable,
	updateFood,
	viewFood,
} from '../controller/foodController'

const router = Router()

router.get('/:foodId', getFood)
router.get('/', viewFood)
router.post('/', putFood)
router.patch('/:foodId', updateFood)
router.patch('/:foodId/setAvailable', setAvailable)
router.patch('/:foodId/setUnAvailable', setUnavailable)
router.delete('/:foodId', deleteFood)

export default router
