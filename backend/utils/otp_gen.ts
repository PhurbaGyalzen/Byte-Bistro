import { IOtp, OtpModel } from "@models/Otp"

const otpLength = parseFloat(process.env.OTP_LENGTH!)
const otpTimeout = parseFloat(process.env.OTP_TIMEOUT_MINS!)



export class OTP {
    static OTPs: Record<string, IOtp> = {}
    static generateOTP() : string {
        let otp = ''
        for (let i = 0; i < otpLength; i++) {
            otp += `${Math.floor(Math.random() * 10)}`
        }
        return otp
    }
    static async add(key: string, value: string): Promise<void> {
        // OTP.OTPs[key] = {
        //     value: value,
        //     expireTimestamp: new Date().getTime() + (otpTimeout * 60_000)
        // }
        const otp = new OtpModel({
            email: key,
            value: value,
            expireTimestamp: new Date().getTime() + (otpTimeout * 60_000)
        })
        await otp.save()

    }
    static async get(key: string): Promise<IOtp | null> {
        // return OTP.OTPs[key] || null
        const otp = await OtpModel.findOne({email: key})
        return otp
    }
    static async remove(key: string): Promise<void> {
        // delete OTP.OTPs[key]
        await OtpModel.deleteOne({
            email: key
        })
    }
}

