import mongoose, { ConnectOptions } from 'mongoose'

export const initDbConnection = async () => {
    await mongoose
        .connect(process.env.MONGO_URL!, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        } as ConnectOptions)
        .then(
            () => {
                console.log('Connected to DB')
            },
            (err) => {
                console.log('Error connecting to DB', err)
            },
        )
}