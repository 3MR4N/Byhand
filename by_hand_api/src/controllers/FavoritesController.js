import model from '../models';
import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Favorites } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);



        try {
            const favorite = await Favorites.findAll({
                where: {
                    user_id: req.params.id
                },
                include: [{

                model:model.Products,
                }]
            });

            // favorite.map((fav) => {
            //     fav.Product.map((item)=>{
            //         item.price=parseFloat(item.price).toFixed(2)

            //     })
            // })
            
            res.json(favorite);
        } catch (ex) {
            console.log(ex)
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },

    async findOne(req, res) {
        localeController.setLocale(req.headers.language);
        const {
            user_id,
            product_id
        } = req.body;
        try {
            const favorite = await Favorites.findOne({
                where: {
                    [Op.and]: {
                        user_id: user_id,
                        product_id: product_id
                    }
                }
            })
            if (favorite) {
                return res.json(favorite);
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
            product_id,
            user_id,

        } = req.body;
        try {
            const favorite = await Favorites.findOne({
                where: {
                    [Op.and]: {
                        user_id: user_id,
                        product_id: product_id
                    }
                }
            })
            if (favorite) {
                return res.status(404).json({
                    message: localeController.translate("Add_fava"),
                });
            }
            
            await Favorites.create({

                product_id,
                user_id,
            });
            return res.status(200).json({
                message: localeController.translate("added_successfully"),
            });

        } catch (ex) {
            console.log(ex);
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            });

        }

    },

    async update(req, res) {
        localeController.setLocale(req.headers.language);

        const {


            product_id,
            user_id,
        } = req.body;

        try {
            const favorite = await Favorites.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (favorite) {
                await Favorites.update({

                    product_id,
                    user_id,
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
            const favorite = await Favorites.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (favorite) {
                await Favorites.destroy({
                    where: {
                        id: req.params.id
                    }
                });


                return res.json({
                    message: localeController.translate("has_been_deleted"),
                });

            } else {
                return res.json({
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









}