import { Strategy as LocalStrategy } from 'passport-local'
import bcrypt from 'bcrypt'
import { User } from '../models/Users'
import passport from 'passport'
import { Strategy as GoogleStrategy } from 'passport-google-oauth2'
import { profile } from 'console'

const GOOGLE_CLIENT_SECRET = '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'
const GOOGLE_CLIENT_ID =
	'578642511664-69u8u6ph1f70usukujdotiricgkn0er2.apps.googleusercontent.com'

export const initialize = (passport: passport.PassportStatic) => {
	passport.use(
		'local-signup',
		new LocalStrategy(
			{
				usernameField: 'username',
				passwordField: 'password',
				passReqToCallback: true,
			},
			async function (req, username, password, done) {
				const body: any = req.body
				// console.log(body);
				if (!body.username || !body.password || !body.email || !body.fullname) {
					return done(null, false, { message: 'All fields are required' })
				}
				const user = await User.findOne({ username: username })

				if (user) {
					return done(null, false, { message: 'Username already exists' })
				}
				const checkEmail = await User.findOne({ email: body.email })

				if (checkEmail) {
					return done(null, false, {
						message: '(Duplicate) Email already exists',
					})
				}

				const hash = await bcrypt.hash(password, 12)
				const newUser: any = new User({
					username,
					passwordHash: hash,
					email: body.email,
					fullname: body.fullname,
					isAdmin: body.isAdmin || false,
				})
				await newUser.save()
				return done(null, {
					username: newUser.username,
					email: newUser.email,
					fullname: newUser.fullname,
					isAdmin: newUser.isAdmin,
				})
			}
		)
	)

	passport.use(
		'local-login',
		new LocalStrategy(
			{
				usernameField: 'username',
				passwordField: 'password',
			},
			async function (username, password, done) {
				const user: any = await User.findOne({ username: username })
				if (!user) {
					return done(null, false, { message: 'User not found' })
				}
				const isPasswordValid = await bcrypt.compare(
					password,
					user.passwordHash
				)
				if (!isPasswordValid) {
					return done(null, false, { message: 'Password is invalid' })
				}
				return done(null, user)
			}
		)
	)
	passport.use(
		new GoogleStrategy(
			{
				clientID: GOOGLE_CLIENT_ID,
				clientSecret: GOOGLE_CLIENT_SECRET,
				callbackURL: 'http://100.102.33.101.xip.io:3000/auth/google/callback',
				passReqToCallback: true,
			},
			async function (
				request: any,
				accessToken: string,
				refreshToken: string,
				profile: any,
				done: any
			) {
				console.log(profile)
				try {
					const user = await User.find({ googleId: profile.id })
					if (user) {
						console.log('User exists')
						return done(null, user)
					}

					const newUser = new User({
						username: profile.displayName,
						email: profile.emails[0].value,
						fullname: profile.name,
						isAdmin: false,
					})
					await newUser.save()
					return done(null, {
						username: newUser.username,
						email: newUser.email,
						fullname: newUser.fullname,
						isAdmin: newUser.isAdmin,
					})
				} catch (err) {
					return done(null, err)
				}
				// console.log(profile);
				// done(null, profile);
			}
		)
	)
}
