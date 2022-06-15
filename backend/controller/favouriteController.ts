import { Request, Response, NextFunction } from 'express'
import { Favourite } from '../models/Favourite';
import { User} from '../models/Users';


export const getFavourite = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourite = await Favourite.findById(req.params.favouriteId).populate('userId').populate("foodId");
        res.status(200).json(favourite)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const getAllFavourites = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourites = await Favourite.find().populate('userId').populate("foodId");
        res.status(200).json(favourites)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const addFavourite = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const { userId, foodId } = req.body
        const findFavorite = await Favourite.findOne({ userId, foodId })
        if (findFavorite) {
            res.status(400).json({ message: "Already in favourite" })
        } else {
            const favourite = new Favourite({ userId: userId, foodId: foodId })
            await favourite.save()
            const user = await User.findOneAndUpdate({ _id: userId }, { $push: { favouriteFoods: favourite._id } }, { new: true })
            res.status(200).json(favourite)
            console.log("created fav");
        }
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
        const favourites = await Favourite.find({ userId: req.params.userId }).populate('userId').populate("foodId");
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


