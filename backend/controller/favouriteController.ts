import { Request, Response, NextFunction } from 'express'
import { Favourite } from '../models/Favourite';
import { User} from '../models/Users';


export const getFavourite = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourite = await Favourite.findById(req.params.favouriteId).populate({path: 'userId',
        select: 'fullname'}).populate("foodId");
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
        const favourites = await Favourite.find().populate({path: 'userId',
        select: 'favoriteFoods'}).populate("foodId");
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
            res.status(409).json({ message: "Already in favourite" })
        } else {
            const favourite = new Favourite({ userId: userId, foodId: foodId })
            await favourite.save()
            const user = await User.findByIdAndUpdate(userId , { $push: { favoriteFoods: foodId } }, { new: true })
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
        const favourites = await Favourite.find({ userId: req.params.userId }).populate({
            path: 'userId',
            select: 'favoriteFoods'
        }).populate("foodId");
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

        const favourite = await Favourite.findById(req.params.favouriteId);
        if (!favourite) {
            res.status(400).json({ message: "Favourite not found" })
        } else {
            const user = await User.findByIdAndUpdate(favourite.userId, { $pull: { favoriteFoods: favourite.foodId } }, { new: true })

            await favourite.remove();
            console.log(user);
            res.status(200).json({ message: "Favourite removed" })
        }   
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const removeAllFavourites = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const favourites = await Favourite.remove();
        res.status(200).json({ message: "All favourites removed" });
    } catch (err) {
        res.status(400).json({ message: err })
    }
}
