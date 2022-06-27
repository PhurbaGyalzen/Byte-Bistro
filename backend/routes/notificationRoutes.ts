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
    getOfferNotification,
    putOfferNotification
} from '../controller/notificationController';


const router = Router()

router.get('/', getAllNotification)
router.post('/', putNotification)
router.post('/offer', putOfferNotification)
router.get('/offer', getOfferNotification);
router.get('/:notificationId', getNotification)
router.get('/user/:userId', getNotificationByUser)
router.patch('/:notificationId', updateNotification)
router.patch('/:notificationId/read', markReadNotification);
router.delete('/:notificationId', deleteNotification)
router.delete('/', deleteAllNotification)

export default router;



