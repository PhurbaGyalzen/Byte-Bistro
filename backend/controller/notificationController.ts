import { NextFunction, Request, Response } from 'express'
import { Notification } from '@models/Notification'

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
    const { userId, message,image ,isOffer } = req.body
    try {
        const notification = new Notification({
            userId: userId,
            message: message,
            image: image,
            read: false,
            isOffer: isOffer,
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
    const { message, read, image,isOffer } = req.body
    try {
        const notification = await Notification.updateOne(
            { _id: req.params.notificationId },
            {
                $set: {
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