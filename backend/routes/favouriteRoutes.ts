import { Router } from 'express'
import { getFavourite, getUserFavourites, addFavourite,removeFavourite, getAllFavourites } from '../controller/favouriteController';


const router = Router()

router.get('/',getAllFavourites);
router.get('/:favouriteId', getFavourite);
router.post('/', addFavourite);
router.get('/user/:userId', getUserFavourites);
router.delete('/:favouriteId', removeFavourite);

export default router;


