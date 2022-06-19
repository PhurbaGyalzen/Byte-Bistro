import { Router } from 'express'
import { uploadImage } from 'middlewares/file'
import {
	deleteFood,
	getFood,
	putFood,
	searchFood,
	setAvailable,
	setUnavailable,
	updateFood,
	viewFood,
} from '../controller/foodController'

const router = Router()

router.get('/:foodId', getFood)
router.get('/', viewFood)
router.post('/', uploadImage.single("image"), putFood)
router.patch('/:foodId', updateFood)
router.patch('/:foodId/setAvailable', setAvailable)
router.patch('/:foodId/setUnAvailable', setUnavailable)
router.delete('/:foodId', deleteFood)
// router to search and filter food
router.get('/search/:foodName', searchFood)

export default router
