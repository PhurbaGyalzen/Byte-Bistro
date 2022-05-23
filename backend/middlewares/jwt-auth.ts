import { Strategy as JWT,ExtractJwt} from 'passport-jwt';
import passport from 'passport';
import { User } from '../models/Users';
import {AUTHORIZATION_FAIL_MSG} from '../config/constants';
import { Request, Response, NextFunction } from 'express'


passport.use('jwt', new JWT({
    secretOrKey: process.env.JWT_SECRET,
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    algorithms: ['HS256']

},  async (token, done) => {
    const user = await User.findById(token.id)
    if (!user) {
        return done(null, false)
    }
    return done(null, user)
}));

export const verifyUser = async (
    req:Request,
    res:Response,
    next:NextFunction)  => {
    passport.authenticate('jwt', (err, user, info) => {
        if (err) {
            return next(err);
        }
        if (!user) {
            return res.status(401).json({ message: AUTHORIZATION_FAIL_MSG  }); // 401 Unauthorized
        }
        req.user = user;
        next();
    })(req, res, next);
}

export const verifyAdmin = async (
    req:Request,
    res:Response,
    next:NextFunction
)=>{
    passport.authenticate('jwt', (err, user, info) => {
        if (err) {
            return next(err);
        }
        if (!user) {
            return res.status(401).json({ message: AUTHORIZATION_FAIL_MSG  }); // 401 Unauthorized
        }
        if(!user.isAdmin){
            return res.status(401).json({ message: AUTHORIZATION_FAIL_MSG  }); // 401 Unauthorized
        }
        req.user = user;
        next();
    })(req, res, next);
}