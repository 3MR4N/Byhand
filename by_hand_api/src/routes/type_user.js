import express from 'express';
import TypeUserController from '../controllers/TypeUserController'

var router = express.Router();
router.get('/:id', TypeUserController.findOne);
router.get('/', TypeUserController.findAll);
router.post('/', TypeUserController.create);
router.put('/:id', TypeUserController.update);
router.delete('/:id', TypeUserController.destroy);

export default router;