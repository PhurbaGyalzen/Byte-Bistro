import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import { initDbConnection } from './config/database'
import passport from 'passport';
import { default as authRoutes } from './routes/authRoutes'

const app = express()
const port = process.env.PORT


app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize())

app.use('/auth', authRoutes)


app.listen(port, async () => {
  await initDbConnection()

})

export { app }