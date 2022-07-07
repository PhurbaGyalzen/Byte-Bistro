import { Router } from 'express'
import {
	
	viewFoodMenu,
} from '../controller/foodController'

const router = Router()

router.get('/', viewFoodMenu)

export default router
