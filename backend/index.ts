import express, { Express, Request, Response } from 'express'
import dotenv from 'dotenv'
import { initDbConnection } from './config/database'
import passport from 'passport'
import { default as authRoutes } from './routes/authRoutes'
import morgan from 'morgan'
import enableCors from 'middlewares/enable-cors'
import helmet from 'helmet'
import foodRoutes from 'routes/foodRoutes'

const app = express()
const port = process.env.PORT

app.use(morgan('dev'))
app.use(helmet())
app.use(enableCors)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize())

app.use('/auth', authRoutes)
app.use('/food', foodRoutes)

app.listen(port, async () => {
	await initDbConnection()
})

export { app }
