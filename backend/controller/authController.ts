import { NextFunction, Request, Response } from 'express'
import passport from 'passport'
import { Strategy as LocalStrategy } from 'passport-local'

import { initialize } from '../config/passport-config'
import jsonwebtoken from 'jsonwebtoken'

initialize(passport)

export const signupUser = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate('local-signup', (err, user, info) => {
		if (err) {
			return next(err)
		}
		if (!user) {
			return res.status(401).json({ message: info.message }) // 401 Unauthorized
		}
		return res.status(201).json(user)
	})(req, res, next) //as next closure
}

export const signinUser = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate('local-login', (err, user, info) => {
		if (err) {
			return next(err)
		}
		if (!user) {
			return res.status(401).json({ message: info.message }) // 401 Unauthorized
		}
		const token = jsonwebtoken.sign(
			{
				id: user._id,
				username: user.username,
			},
			process.env.JWT_SECRET!,
			{ expiresIn: '2d' }
		)
		return res
			.status(200)
			.json({
				message: 'User logged in successfully',
				token: token,
				isAdmin: user['isAdmin'],
			})
	})(req, res, next) //as next closure
}
