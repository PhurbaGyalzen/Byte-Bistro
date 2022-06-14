import express, { Express, Request, Response } from 'express'
import dotenv from 'dotenv'
import { initDbConnection } from './config/database'
import passport from 'passport'
import { default as authRoutes } from './routes/authRoutes'
import { default as qrRoutes } from './routes/qrRoutes'
import { default as cartRoutes } from './routes/cartRoutes'
import {default as notificationRoutes} from './routes/notificationRoutes'
import {default as favouriteRoutes} from './routes/favouriteRoutes'
import morgan from 'morgan'
import enableCors from 'middlewares/enable-cors'
import helmet from 'helmet'
import foodRoutes from 'routes/foodRoutes'
import initWebSocket from 'index.ws'
import categoryRoutes from 'routes/categoryRoutes'
import { verifyUser } from 'middlewares/jwt-auth'

const app = express()
app.use(morgan('combined'))
const port = process.env.PORT

app.use(morgan('dev'))
app.use(helmet())
app.use(enableCors)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize({ userProperty: 'currentUser' }))
app.use('/food', foodRoutes)
app.use('/category', categoryRoutes)
app.use('/cart', cartRoutes)
app.use('/favourite', favouriteRoutes)

app.use('/auth' , authRoutes)
app.use('/qr', qrRoutes)
app.use('/notification', notificationRoutes)

app.listen(port, async () => {
	await initDbConnection()
	const httpServer = initWebSocket(app)
	httpServer.listen(process.env.WSS_PORT, () => {
		console.log(
			`🔌[WS]: Server is running at http://localhost:${process.env.WSS_PORT}`
		)
	})
	console.log(`⚡️[TCP]: Server is running at http://localhost:${port}`)
})

export { app }
