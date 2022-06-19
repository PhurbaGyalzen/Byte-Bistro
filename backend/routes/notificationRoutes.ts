import { Router } from 'express'


import {
    getNotification,
    getAllNotification,
    getNotificationByUser,
    putNotification,
    updateNotification,
    deleteNotification,
    deleteAllNotification,
    markReadNotification,
    getOfferNotification
} from '../controller/notificationController';


const router = Router()

router.get('/', getAllNotification)
router.get('/offer', getOfferNotification);
router.get('/:notificationId', getNotification)
router.get('/user/:userId', getNotificationByUser)
router.patch('/:notificationId', updateNotification)
router.patch('/:notificationId/read', markReadNotification);
router.post('/', putNotification)
router.delete('/:notificationId', deleteNotification)
router.delete('/', deleteAllNotification)

export default router;



