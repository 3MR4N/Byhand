import express from 'express';
import CategorysController from '../controllers/CategorysController'

var router = express.Router();
router.get('/:id', CategorysController.findOne);
router.get('/', CategorysController.findAll);
router.post('/', CategorysController.create);
router.put('/:id', CategorysController.update);
router.delete('/:id', CategorysController.destroy);

export default router;