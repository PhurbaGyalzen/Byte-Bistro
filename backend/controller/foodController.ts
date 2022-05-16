import { Request, Response, NextFunction } from 'express'
import { Food } from '../models/Food'

export const getFood = async (
    req: Request,
    res: Response,
    next: NextFunction,
) => {
    const food = await Food.findById(req.params.foodId)
    if (!food) {
        return res.status(404).json({
            success: false,
            message: 'Food not found',
        })
    }
    return res.json({ success: true, data: food })
}
