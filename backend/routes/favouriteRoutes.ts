import { Router } from 'express'
import { getFavourite, getUserFavourites, addFavourite,removeFavourite, getAllFavourites } from '../controller/favouriteController';


const router = Router()

router.post('/', addFavourite);
router.get('/:favouriteId', getFavourite);
router.get('/user/:userId', getUserFavourites);
router.delete('/:favouriteId', removeFavourite);
router.get('/',getAllFavourites);

export default router;


