import { Router, Request, Response, NextFunction } from 'express'
import { signupUser, signinUser, authGoogle, authGoogleCallback, authFailure, authSuccess, resetPassword, verifyResetPassword } from '../controller/authController'
import { User } from '@models/Users';
import { verifyUser } from 'middlewares/jwt-auth';

const router = Router()


router.post('/signup', signupUser);
router.post(
    '/signin',

    signinUser,
)
router.post('/resetPassword', resetPassword)
router.post('/verifyResetPassword', verifyResetPassword)
router.get('/google',authGoogle);
router.get('/google/callback',authGoogleCallback);
router.get('/google/failed',authFailure);
router.get('/google/success',authSuccess);



router.get('/all_user', async (
    req: Request,
    res: Response,
    next: NextFunction

) => {
    try {
        const users = await User.find()
        res.status(200).json(users)
    }
    catch (err) {
        res.status(400).json({ message: err })
    }
})
router.get('/one_user', verifyUser, async (
    req: Request,
    res: Response,
    next: NextFunction

) => {
    console.log("req.user")
    console.log(req.user)

    try {
        const users = await User.findById(req.user?.id)


        res.status(200).json(users)
    }
    catch (err) {
        res.status(400).json({ message: err })
    }
})



router.put('/profile_update', verifyUser, async (
    req: Request,
    res: Response,
    next: NextFunction

) => {
    try {
        const users = await User.findByIdAndUpdate(req.user?.id, {
            $set: {
                fullname: req.body.fullname,
                email: req.body.email,
                phones: req.body.phone,
                address: req.body.address,
                bio: req.body.bio,
            }
        })
        res.status(200).json(users)
    }
    catch (err) {
        res.status(400).json({ message: err })
    }
})





export default router