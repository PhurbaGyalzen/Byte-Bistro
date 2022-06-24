import mongoose, { Types } from "mongoose"

export interface IOtp {
    email: string
    value: string
    expireTimestamp: number
}

interface IOtpDoc extends IOtp, Document {}

const OtpSchemaFields : Record<keyof IOtp, any> = {
    email: {
        type: String,
        required: true,
        index: true
    },
    value: {
        type: String,
        required: true,
    },
    expireTimestamp: {
        type: Number,
        required: true
    }
}

const OtpSchema = new mongoose.Schema<IOtpDoc>(OtpSchemaFields)

export const OtpModel = mongoose.model<IOtpDoc>('Otp', OtpSchema)