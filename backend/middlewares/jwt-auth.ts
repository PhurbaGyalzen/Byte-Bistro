import express, { Request, Response, NextFunction } from 'express'
import { ExtractJwt,Strategy as JWT} from 'passport-jwt';
import passport from 'passport';
import { User } from '../models/Users';
import {AUTHORIZATION_FAIL_MSG} from '../config/constants';


// passport.serializeUser((user, done) => {
//     done(null, user.id)
// })

// passport.deserializeUser(async(id, done) => {
//     const user = await User.findById(id)
//     done(null, user)
// })


passport.use('jwt', new JWT({
    secretOrKey: process.env.JWT_SECRET,
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    algorithms: ['HS256'],
    passReqToCallback: true,

},  async (req:Request,token:any, done:any) => {
    // console.log(token);
    console.log(token);
    const user = await User.findById(token.id)
    if (!user) {
        return done(null, false)
    }
    req.user = user;
    console.log(user);
    return done(null, user)
    
}));


export const verifyUser = async (
    req:Request,
    res:Response,
    next:NextFunction)  => {
    passport.authenticate('jwt',{session : false} ,(err, user) => {
        if (err) {
            return next(err);
        }
        console.log(user);
        if (!user) {
            return res.status(401).json({ message: AUTHORIZATION_FAIL_MSG  }); // 401 Unauthorized
        }
        console.log(user);
        // console.log(user);
        // req.user = user;
        // console.log(req.user);
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