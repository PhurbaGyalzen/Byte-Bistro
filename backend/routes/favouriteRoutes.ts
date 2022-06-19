import { Router } from 'express'
import { getFavourite, getUserFavourites, addFavourite,removeFavourite, getAllFavourites, removeAllFavourites } from '../controller/favouriteController';


const router = Router()

router.post('/', addFavourite);
router.get('/:favouriteId', getFavourite);
router.get('/user/:userId', getUserFavourites);
router.delete('/', removeAllFavourites);
router.delete('/:favouriteId', removeFavourite);
router.get('/',getAllFavourites);

export default router;


