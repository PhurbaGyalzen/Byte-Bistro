import { Router } from 'express'
import { signupUser } from '../controller/authController'

const router = Router()


router.post('/signup', signupUser);


export default router