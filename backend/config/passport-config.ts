import { Strategy as LocalStrategy } from 'passport-local';
import bcrypt from 'bcrypt';
import { User } from '../models/Users';



export const initialize = (passport: any) => {
    passport.use('local-signup',
        new LocalStrategy({
            usernameField: 'username',
            passwordField: 'password',
            passReqToCallback: true,
        },
        async function (req,username, password, done) {
            const body = req.body;
            // console.log(body);
            if (!body.username || !body.password || !body.email || !body.fullname) {
                return done(null, false, { message: 'All fields are required' });
            }
            const user = await User.findOne({ username: username })
            
            if (user) {
                return done(null, false, { message: 'Username already exists' })
            }
            const checkEmail = await User.findOne({ email: body.email })

            if (checkEmail) {
                return done(null, false, {message:'(Duplicate) Email already exists'})
            }

            const hash = await bcrypt.hash(password, 12)
            const newUser = new User({ username, passwordHash: hash, email: body.email, fullname: body.fullname})
            await newUser.save()
            return done(null, {
                username: newUser.username,
                email: newUser.email,
                fullname: newUser.fullname,
                isAdmin: newUser.isAdmin,

            })
        }),
    );

    passport.use('local-login',
        new LocalStrategy({
            usernameField: 'username',
            passwordField: 'password',
        },
        async function (username, password, done) {
            const user = await User.findOne({ username: username })
            if (!user) {
                return done(null, false, { message: 'User not found' })
            }
            const isPasswordValid = await bcrypt.compare(password, user.passwordHash)
            if (!isPasswordValid) {
                return done(null, false, { message: 'Password is invalid' })
            }
            return done(null, user)

        }
    ));
    }