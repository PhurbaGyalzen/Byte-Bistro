import { Router } from 'express'


import {
    getNotification,
    getAllNotification,
    getNotificationByUser,
    putNotification,
    updateNotification,
    deleteNotification,
    deleteAllNotification
} from '../controller/notificationController';


const router = Router()

router.get('/', getAllNotification)
router.get('/:notificationId', getNotification)
router.get('/user/:userId', getNotificationByUser)
router.patch('/:notificationId', updateNotification)
router.post('/', putNotification)
router.delete('/:notificationId', deleteNotification)
router.delete('/', deleteAllNotification)

export default router;



