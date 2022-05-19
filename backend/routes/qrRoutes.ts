import { Router,Request, Response, NextFunction } from "express";
import * as qrController from "../controller/qrController";

const router: Router = Router();

router.post('/generate', qrController.qrCodeGenerate);
router.post('/generateJson', qrController.jsonQrCodeGenerate);
router.get('/',(req:Request,res:Response)=>{
    res.send('QR code generation');
});

export default router;