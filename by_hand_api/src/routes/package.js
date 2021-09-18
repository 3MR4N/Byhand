import express from 'express';
import PackageController from '../controllers/PackageController'

var router = express.Router();
router.get('/:id', PackageController.findOne);
router.get('/', PackageController.findAll);
router.post('/', PackageController.create);
router.put('/:id', PackageController.update);
router.delete('/:id', PackageController.destroy);

export default router;