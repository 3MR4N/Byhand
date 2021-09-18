import express from 'express';
import NotesController from '../controllers/NotesController'

var router = express.Router();
router.get('/:id', NotesController.findOne);
router.get('/', NotesController.findAll);
router.post('/', NotesController.create);
router.put('/:id', NotesController.update);
router.delete('/:id', NotesController.destroy);

export default router;