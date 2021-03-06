import { NextFunction, Request, Response } from 'express'
import passport from 'passport'

import { initialize, passwordHasher } from '../config/passport-config'
import jsonwebtoken from 'jsonwebtoken'
import { IUserDoc, User } from '@models/Users'
import nodemailer from 'nodemailer'
import { OTP } from '@utils/otp_gen'
import { jwtSigner } from 'middlewares/jwt-auth'

initialize(passport)

export const signupUser = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate('local-signup', (err, user, info) => {
		if (err) {
			console.log(err)
			return next(err)
		}
		if (!user) {
			console.log(info);
			return res.status(401).json({ message: info.message }) // 401 Unauthorized
		}
		return res.status(201).json(user)
	})(req, res, next) //as next closure
}

const localLogin = (req: Request, res: Response, next: NextFunction) => {
	return (err: any, user: IUserDoc | null, info: any) => {
		if (err) {
			return next(err)
		}
		if (!user) {
			return res.status(401).json({ message: info.message }) // 401 Unauthorized
		}
		const token: string = jwtSigner(user)
		return res.status(200).json({
			message: 'User logged in successfully',
			token: token,
			isAdmin: user['isAdmin'],
		})
	}
}

export const signinUser = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate('local-login', localLogin(req, res, next))(
		req,
		res,
		next
	)
}


export const googleAuthentication = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {

	const {email, googleId, username, fullname} = req.body;
	const user = await User.findOne({ googleId: googleId });
	if (user) {
		return localLogin(req, res, next)(null, user, null)
	}
	else {
		const newUser = new User({
			email: email,
			googleId: googleId,
			username: username,
			fullname: username,
			isAdmin: false,
		});
		await newUser.save();
		const token: string = jwtSigner(newUser)
		return res.status(200).json({
			message: 'User Signed up and logged in',
			token: token,
			isAdmin: newUser['isAdmin'],
		});
	}

}


export const authGoogle = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate('google', {
		scope: ['profile', 'email'],
		prompt: 'select_account',
	})(req, res, next)
}



export const authGoogleCallback = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	passport.authenticate(
		'google',
		{
			session: false,
			successRedirect: '/google/success',
			failureRedirect: '/google/failed',
		},
		localLogin(req, res, next)
	)(req, res, next)
}

export const authSuccess = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	res.status(200).json({ message: 'Successful Google authentication' })
}

export const authFailure = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	res.status(401).json({ message: 'Failed Google authentication' })
}

const OTP_TIMEOUT_MINS = parseFloat(process.env.OTP_TIMEOUT_MINS!)
const OTP_LENGTH = parseFloat(process.env.OTP_LENGTH!)

export const resetPassword = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const email = req.body.email
	const user = await User.findOne({
		email: email,
	})

	if (user) {
		const transport = nodemailer.createTransport({
			host: 'smtp.mailtrap.io',
			port: 2525,
			secure: false,
			auth: {
				user: process.env.MAIL_USERNAME,
				pass: process.env.MAIL_PASS,
			},
		})
		const otp = OTP.generateOTP()
		OTP.add(user.email, otp).then(() => {

			let info = transport
				.sendMail({
					from: '"Byte Bistro ????" <byte@bistro.com>', // sender address
					to: `${user.email}`, // list of receivers
					subject: 'OTP Code',
					text: `Your OTP code for Byte Bistro is ${otp}`,
					html: `<h1>Your OTP code for Byte Bistro is</h1> <pre>${otp}</pre>`,
				})
				.then((info) => {
					console.log('Message sent: %s', info.messageId)
					console.log(OTP.OTPs)
				}).catch((err) => {
					console.log(err)
				})
		})
	}
	// do not leak unnecessary information. always serve this response regardless of any shortcomings.
	return res.status(200).json({
		success: true,
		message: `An email with a OTP has been sent to ${email}, if it exists.`,
		otpTimeoutMins: OTP_TIMEOUT_MINS,
		otpLength: OTP_LENGTH
	})
}

export const verifyResetPassword = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const email = req.body.email
	const otp = req.body.otp

	const otpObj = await OTP.get(email)
	if (!otpObj || otpObj.value !== otp) {
		return res
			.status(401)
			.json({ success: false, message: 'OTP does not match' })
	}
	
	await OTP.remove(email)
	if (otpObj.expireTimestamp < new Date().getTime()) {
		return res
			.status(403)
			.json({ success: false, message: 'OTP has already expired.' })
	}
	
	const user = await User.findOne({ email: email })
	return localLogin(req, res, next)(null, user, null)
	// now redirect to change password from frontend
}

export const setNewPassword = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const newPassword = req.body.newPassword
	const hashedPassword = await passwordHasher(newPassword)
	const user = await User.findByIdAndUpdate(req.user!.id, {
		$set: {
			passwordHash: hashedPassword
		} 
	})
	return res.status(200).json({success: true, message: 'Password updated successfully.'})
	// now redirect to change password from frontend
}

