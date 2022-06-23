
const otpLength = parseInt(process.env.OTP_LENGTH!, 10)
const OTP_TIMROUT_MINS = 5

interface IOtp {
    value: string
    expireTimestamp: number
}

export class OTP {
    static OTPs: Record<string, IOtp> = {}
    static generateOTP() : string {
        let otp = ''
        for (let i = 0; i < otpLength; i++) {
            otp += `${Math.floor(Math.random() * 10)}`
        }
        return otp
    }
    static add(key: string, value: string): void {
        OTP.OTPs[key] = {
            value: value,
            expireTimestamp: new Date().getTime() + (OTP_TIMROUT_MINS * 60_000)
        }
    }
    static get(key: string): IOtp | null {
        return OTP.OTPs[key] || null
    }
    static remove(key: string): void {
        delete OTP.OTPs[key]
    }
}

