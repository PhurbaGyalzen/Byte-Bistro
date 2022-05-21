import { Request, Response, NextFunction } from 'express'
import { IMenuItem } from '../models/Food'
const qrcode = require('qrcode')

interface IqrCodeGenerate {
    text: string
}

interface Itable {
    tableNumber: number
}

interface Options {
    errorCorrectionLevel: string
    type: string
    margin: number
    quality: number
    color: {
        dark: string
        light: string
    }
}

const OPTIONS: Options = {
    errorCorrectionLevel: 'H',
    type: 'image/png',
    margin: 1,
    quality: 0.3,
    color: {
        dark: '#010599FF',
        light: '#FFBF60FF',
    },
}

export const qrCodeGenerate = async (
    req: Request,
    res: Response,
    next: NextFunction,
) => {
    console.log('qrCodeGenerate')
    const data: IqrCodeGenerate = await req.body

    await qrcode.toDataURL(data.text, OPTIONS, (err: any, url: String) => {
        if (err) {
            console.log('error is error', err)

            res.status(500).send(err)
        } else {
            let img = Buffer.from(
                url.replace(/^data:image\/\w+;base64,/, ''),
                'base64',
            )
            res.writeHead(200, {
                'Content-Type': 'image/png',
                // 'Content-Length': url.length,
            })
            res.end(img)
        }
    })
}

export const jsonQrCodeGenerate = async (
    req: Request,
    res: Response,
    next: NextFunction,
) => {
    console.log('qrCodeGenerate json')
    const data: Itable = req.body
    const jsonStr: String = JSON.stringify(data)

    await qrcode.toDataURL(jsonStr, (err: any, url: String) => {
        if (err) {
            console.log('error is error', err)

            res.status(500).send(err)
        } else {
            let img = Buffer.from(
                url.replace(/^data:image\/\w+;base64,/, ''),
                'base64',
            )
            res.writeHead(200, {
                'Content-Type': 'image/png',
                // 'Content-Length': url.length,
            })
            res.end(img)
        }
    })
}
