import express from 'express';
import ProductsController from '../controllers/ProductsController'

var router = express.Router();
router.get('/:id', ProductsController.findOne);
router.get('/', ProductsController.findAll);
router.get('/user/:id', ProductsController.findAllUser);
router.get('/product_user/:id', ProductsController.productsUser);

router.post('/', ProductsController.create);
router.put('/:id', ProductsController.update);
router.delete('/:id', ProductsController.destroy);

export default router;