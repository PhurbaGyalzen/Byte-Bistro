import { Router } from "express";

import {getCart,viewCart,putCart,updateCart,deleteCart} from "../controller/cartController";

const router = Router();

router.get("/", getCart);
router.get("/view", viewCart);
router.put("/", putCart);
router.put("/update", updateCart);
router.delete("/", deleteCart);

export default router;
