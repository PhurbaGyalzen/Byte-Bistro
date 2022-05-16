import { Router } from 'express'
import { getFood, putFood, viewFood } from '../controller/foodController'

const router = Router()

router.get('/:foodId', getFood)
router.get('/', viewFood)
router.post('/', putFood)

export default router
