import express, { Express, Request, Response } from 'express'
import { initDbConnection } from './config/database'
import passport from 'passport'
import { default as authRoutes } from './routes/authRoutes'
import { default as qrRoutes } from './routes/qrRoutes'
import { default as cartRoutes } from './routes/cartRoutes'
import { default as notificationRoutes } from './routes/notificationRoutes'
import { default as favouriteRoutes } from './routes/favouriteRoutes'
import morgan from 'morgan'
import enableCors from 'middlewares/enable-cors'
import helmet from 'helmet'
import foodRoutes from 'routes/foodRoutes'
import menuRoutes from 'routes/menuRoutes'
import initWebSocket from 'index.ws'
import categoryRoutes from 'routes/categoryRoutes'

const app = express()
app.use(morgan('combined'))

app.use(morgan('dev'))
app.use(helmet())
app.use(enableCors)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize({ userProperty: 'currentUser' }))
app.use('/food', foodRoutes)
app.use('/menu', menuRoutes)
app.use('/category', categoryRoutes)
app.use('/cart', cartRoutes)
app.use('/favourite', favouriteRoutes)

app.use('/auth', authRoutes)
app.use('/qr', qrRoutes)
app.use('/notification', notificationRoutes)

app.use(express.static('public'))

const httpServer = initWebSocket(app)
const PORT = parseInt(process.env.PORT!, 10)
httpServer.listen(PORT, async () => {
	await initDbConnection()
	console.log(`
	⚡️[TCP]: Server is running at http://localhost:${PORT}
	🔌[WS ]: Server is running at http://localhost:${PORT}`)
})
export { app }
