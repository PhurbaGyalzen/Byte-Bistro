import { Router } from 'express'
import {
	deleteFood,
	getFood,
	putFood,
	updateFood,
	viewFood,
} from '../controller/foodController'

const router = Router()

router.get('/:foodId', getFood)
router.get('/', viewFood)
router.post('/', putFood)
router.patch('/:foodId', updateFood)
router.delete('/:foodId', deleteFood)

export default router
