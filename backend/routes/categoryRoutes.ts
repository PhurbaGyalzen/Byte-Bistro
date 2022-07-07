import { Router } from 'express';
import {
  addCategory,
  getCategories,
  deleteCategory,
} from '../controller/categoryController';

const router = Router();

router.get('/', getCategories);
router.post('/', addCategory);
router.delete('/:categoryId', deleteCategory);

export default router;
