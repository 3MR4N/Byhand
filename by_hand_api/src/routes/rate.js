import express from 'express';
import RatesController from '../controllers/RatesController'

var router = express.Router();
router.get('/:id', RatesController.findOne);
router.get('/', RatesController.findAll);
router.get('/sum/:id', RatesController.getSum);

router.post('/', RatesController.create);
router.put('/:id', RatesController.update);
router.delete('/:id', RatesController.destroy);

export default router;