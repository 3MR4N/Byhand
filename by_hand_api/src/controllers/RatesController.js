import model from '../models';
import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Rates } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const rate = await Rates.findAll({

            });
            res.json(rate);
        } catch (ex) {
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },

    async findOne(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const rate = await Rates.findOne({
                where: {
                    id: req.params.id
                }
            })
            if (rate) {
                return res.json(rate);
            } else {
                return res.status(404).json({
                    message: localeController.translate("not_found"),
                });
            }

        } catch (ex) {
            console.log(ex);
            res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            });
        }

    },


    async create(req, res) {
        localeController.setLocale(req.headers.language);

        const {
            user_product,
            product_id,
            value_rate,

        } = req.body;
        
        try {

            const rate = await Rates.findOne({
                where: {
                    user_product:user_product
                }
            })
            if(rate){
                return res.status(404).json({
                    message: localeController.translate("لقد قمت بالتقيم من قبل"),
                });
           
        }

        await Rates.create({
            user_product,
            product_id,
            value_rate,
        });
        return res.status(200).json({
            message: localeController.translate("added_successfully"),
        });
       
        } catch (ex) {
            console.status(500).log(ex);
            return res.json({
                    message: localeController.translate("Could_not_perform"),
                });

        }

    },

    async update(req, res) {
        localeController.setLocale(req.headers.language);

        const {

            user_product,
            product_id,
            value_rate,
        } = req.body;

        try {
            const rate = await Rates.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (rate) {
                await Rates.update({
                    user_product,
                    product_id,
                    value_rate,
                }, {

                    where: {
                        id: req.params.id
                    }
                });
                return res.status(200).json({
                    message: localeController.translate("updated_successfully"),
                });
            } else {
                return res.status(404).json({
                    message: localeController.translate("not_found"),
                });
            }
        } catch (ex) {
            console.log(ex);
            return res.status(500).json({
                    message: localeController.translate("Could_not_perform"),
                });

        }

    },

    async destroy(req, res) {
        localeController.setLocale(req.headers.language);

        try {
            const rate = await Rates.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (rate) {
                await Rates.destroy({
                    where: {
                        id: req.params.id
                    }
                });


                return res.status(200).json({
                    message: localeController.translate("has_been_deleted"),
                });

            } else {
                return res.status(404).json({
                    message: localeController.translate("not_found"),
                });
            }

        } catch (ex) {
            console.log(ex);
            return res.status(500)
                .json({
                    message: localeController.translate("Could_not_perform"),
                });

        }


    },

    async getSum(req, res) {

        try {
            const rate = await Rates.sum('value_rate', {
                where: {
                    [Op.and]: [
                        { product_id: req.params.id },
                      ]
                    
                }
            },

            );

            res.json(parseFloat(rate).toFixed(2));

        } catch (error) {
            console.log(error)
            return res.status(500).json({
                message: 'Could not perform operation at this time, kindly try again later.'
            })
        }

    }
,

async getSumRate(id) {

    try {
        const rate = await Rates.sum('value_rate', {
            where: {
                [Op.and]: [
                    { product_id: id },
                  ]
                
            }
        },

        );

        return parseFloat(rate).toFixed(2);

    } catch (error) {
        console.log(error)
        throw error
    }

}






}