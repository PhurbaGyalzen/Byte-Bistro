import { Router } from 'express'
import { addCategory, getCategories } from '../controller/categoryController'

const router = Router()

router.get('/', getCategories)
router.post('/', addCategory)

export default router
