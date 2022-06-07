import { Router } from 'express'


import {
    getNotification,
    getNotificationByUser,
    putNotification,
    updateNotification,
    deleteNotification
} from '../controller/notificationController';


const router = Router()

router.get('/', getNotification)
router.get('/:userId', getNotificationByUser)
router.put('/', updateNotification)
router.post('/', putNotification)
router.delete('/:notificationId', deleteNotification)

export default router;



