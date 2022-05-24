import { Router, Request, Response, NextFunction } from 'express'
import { signupUser, signinUser } from '../controller/authController'
import { User } from '@models/Users';

const router = Router()


router.post('/signup', signupUser);
router.post(
    '/signin',
    signinUser,
)
router.get('/', async(
    req: Request,
	res: Response,
	next: NextFunction

) => {
    try{
        const users = await User.find()
        res.status(200).json(users)
    }
    catch(err){
        res.status(400).json({ message: err })
    }
})


export default router