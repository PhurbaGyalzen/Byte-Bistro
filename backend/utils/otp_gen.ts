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
    // subtle bug. if query is not sorted and db has multiple OTPs for same email,
	// the stale one maybe be used resulting in incorrect comparison.
    static async get(key: string): Promise<IOtp | null> {
        // return OTP.OTPs[key] || null
        // const otp = await OtpModel.find({email: key}).sort({expireTimestamp: -1})
        const otp = await OtpModel.find({email: key}).sort({createdAt: -1})
        return otp[0]
    }
    static async remove(key: string): Promise<void> {
        // delete OTP.OTPs[key]
        await OtpModel.deleteMany({
            email: key
        })
    }
}

