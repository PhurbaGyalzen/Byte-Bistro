import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import { initDbConnection } from './config/database'
import passport from 'passport';
import { default as authRoutes } from './routes/authRoutes'
import cors from 'cors';
import morgan from 'morgan';


const app = express()
app.use(morgan('combined'))
app.use(cors())
const port = process.env.PORT


app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize())

app.use('/auth', authRoutes)


app.listen(port, async () => {
  await initDbConnection()

})

export { app }