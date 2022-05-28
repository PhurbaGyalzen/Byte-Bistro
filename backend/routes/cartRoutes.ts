import { Router } from 'express'
import { verifyUser } from 'middlewares/jwt-auth'

import {
	getCart,
	viewCart,
	createCart,
	updateCart,
	deleteCart,
	addRemoveItem,
	userCart,
} from '../controller/cartController'

const router = Router()

import { ExtractJwt,Strategy as JWT} from 'passport-jwt';
import passport from 'passport';
import { User } from '../models/Users';
import {AUTHORIZATION_FAIL_MSG} from '../config/constants';

passport.use('jwt', new JWT({
    secretOrKey: process.env.JWT_SECRET,
    jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme("Bearer"),
    algorithms: ['HS256'],
    passReqToCallback: true,

},  async (token, done) => {
	console.log(process.env.JWT_SECRET);
    console.log(token);
    console.log(token.user);
    const user = await User.findById(token.id)
    if (!user) {
        return done(null, false)
    }
    console.log(user);
    return done(null, user)
    
}));




router.get('/', verifyUser,viewCart)
router.get('/:cartId', getCart)
router.post('/', createCart)
router.patch('/', addRemoveItem)
router.put('/', updateCart)
router.delete('/:cartId', deleteCart)
router.get('/:userId', userCart)

export default router
