import { Request, Response, NextFunction } from 'express'
import { Favourite } from '../models/Favourite';


export const getFavourite = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourite = await Favourite.findById(req.params.favouriteId).populate('userId food')
        res.status(200).json(favourite)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const getUserFavourites = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourites = await Favourite.find({ userId: req.params.userId }).populate('userId food')
        res.status(200).json(favourites)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const removeFavourite = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourite = await Favourite.findByIdAndDelete(req.params.favouriteId)
        res.status(200).json(favourite)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

