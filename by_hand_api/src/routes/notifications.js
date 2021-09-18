import express from 'express';
import NotificationsController from '../controllers/NotificationsController'

var router = express.Router();
router.get('/:id', NotificationsController.findOne);
router.get('/', NotificationsController.findAll);
router.post('/', NotificationsController.create);
router.put('/:id', NotificationsController.update);
router.delete('/:id', NotificationsController.destroy);

export default router;