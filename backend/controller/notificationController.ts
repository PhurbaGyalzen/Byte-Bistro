import { NextFunction, Request, Response } from 'express'
import { Notification } from '@models/Notification'
import { title } from 'process'

export const getAllNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.find().populate({
            path: 'userId',
            select: 'fullname',
        })
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const getNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.findById(req.params.notificationId)
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const getNotificationByUser = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.find({
            userId: req.params.userId,
            isOffer: false
        }).populate({
            path: 'userId',
            select: 'fullname',
        })
        res.status(200).json(notification)
    }
    catch (err) {
        res.status(400).json({ message: err })
    }
}

export const getOfferNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
 ) => {
    try {
        const notification = await Notification.find({
            isOffer: true,
        }).populate({
            path: 'userId',
            select: 'fullname',
        })
        res.status(200).json(notification)
    }   
    catch (err) {
        res.status(400).json({ message: err })
    }   
}

export const putNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    const { title,userId, message,image ,isOffer } = req.body
    try {
        const notification = new Notification({
            title: title,
            userId: userId,
            message: message,
            image: image,
            read: false,
            isOffer: false,
        })
        await notification.save()
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const putOfferNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    const { title, message,image  } = req.body
    const imageFileName = req.file?.filename;
    const imageFileUrl = `images/${imageFileName}`;
    try {

        const notification = new Notification({
            title: title,
            message: message,
            image: imageFileUrl,
            isOffer: true,
        })
        await notification.save()
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}


export const updateNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    const { title,message, read, image,isOffer } = req.body
    try {
        const notification = await Notification.updateOne(
            { _id: req.params.notificationId },
            {
                $set: {
                    title: title,
                    message: message,
                    read: read,
                    image: image,
                    isOffer: isOffer,
                },
            }
        )
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}

export const deleteNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.remove({
            _id: req.params.notificationId,
        })
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}


export const deleteAllNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.remove({})
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}


export const markReadNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
    try {
        const notification = await Notification.updateOne(
            { _id: req.params.notificationId },
            {
                $set: {
                    read: true,
                },
            }
        )
        res.status(200).json(notification)
    } catch (err) {
        res.status(400).json({ message: err })
    }
}
