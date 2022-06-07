import { NextFunction, Request, Response } from 'express'
import { Notification } from '@models/Notification'

export const getNotification = async (
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
    const { userId, message, type } = req.body
    try {
        const notification = new Notification({
            userId: userId,
            message: message,
            read: false,
            type: type,
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
    const { message, read, type } = req.body
    try {
        const notification = await Notification.updateOne(
            { _id: req.params.notificationId },
            {
                $set: {
                    message: message,
                    read: read,
                    type: type,
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


