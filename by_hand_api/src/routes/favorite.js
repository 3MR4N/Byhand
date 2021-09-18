import express from 'express';
import FavoritesController from '../controllers/FavoritesController'

var router = express.Router();
router.get('/:id', FavoritesController.findOne);
router.get('/user/:id', FavoritesController.findAll);
router.post('/', FavoritesController.create);
router.put('/:id', FavoritesController.update);
router.delete('/:id', FavoritesController.destroy);

export default router;