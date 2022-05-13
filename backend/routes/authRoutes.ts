import { Router } from 'express'
import { signupUser, signinUser } from '../controller/authController'


const router = Router()


router.post('/signup', signupUser);
router.post(
    '/signin',
    signinUser,
)


export default router