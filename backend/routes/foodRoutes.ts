import { Router } from 'express';
import { putFood, viewFood } from '../controller/foodController';

const router = Router();

router.get('/', viewFood);
router.post('/', putFood);

export default router;
