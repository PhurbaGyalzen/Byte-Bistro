import { Router } from 'express'
import { getFood } from '../controller/foodController'

const router = Router()

router.get('/:foodId', getFood)

export default router
