import express from 'express';
import AuthController from '../controllers/AuthController'

var router = express.Router();
router.post('/login', AuthController.login);
router.get('/', AuthController.findAll);
router.get('/:id', AuthController.findOne);
router.post('/register', AuthController.signUp);
router.put('/:id', AuthController.update);
router.put('/type/:id', AuthController.updateType);

router.delete('/:id', AuthController.destroy);

export default router;