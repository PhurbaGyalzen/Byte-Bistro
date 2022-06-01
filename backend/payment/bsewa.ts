import fetch from 'node-fetch'

const ORIGIN_SERVER = 'https://uat.esewa.com.np'
const PAYMENT_VERIFY_ENDPOINT = '/epay/transrec'

type TranscationParams = {
    amount: number
    refId: string
    productId: string
    merchantCode: string
}

type VerifyParams = {
    amt: string
    rid: string
    pid: string
    scd: string
}

enum Transaction {
    OK = "Success",
    FAIL = "failure"
}


export const verifyTransaction = async ({amount, refId, productId, merchantCode}: TranscationParams) => {
    const params: VerifyParams = {
        amt: amount.toString(),
        rid: refId,
        pid: productId,
        scd: merchantCode
    }
    const payload = new URLSearchParams(params)
    const response = await fetch(ORIGIN_SERVER + PAYMENT_VERIFY_ENDPOINT, {
        method: 'POST',
        body: payload
    })
    const data = await response.text() as Transaction
    const resp = {
        success: data === Transaction.OK
    }
    return resp
}

