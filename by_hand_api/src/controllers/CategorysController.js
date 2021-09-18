import model from '../models';
import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Categorys } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const category = await Categorys.findAll({
            });
            res.json(category);
        } catch (ex) {
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },

    async findOne(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const category = await Categorys.findOne({
                include:[
                    model.Products,
                ],
                where: {
                    id: req.params.id
                }
            });

            
            // category.Products.map((item) => {
            //         item.dataValues.price = parseFloat(item.dataValues.price).toFixed(2);
            //     });
            
      
            res.json(category);
             

        } catch (ex) {
            console.log(ex);
            res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            });
        }

    },


    async create(req, res) {
        localeController.setLocale(req.headers.language);

        var  image_url=req.file.path;
        image_url=image_url.replace("\\","/");

        const {
            name,
        } = req.body;
        try {
            await Categorys.create({
                name,
                image_url

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
            name,
        } = req.body;

        try {
            const category = await Categorys.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (category) {
                await Categorys.update({

                    name,
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
            const category = await Categorys.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (category) {
                await Categorys.destroy({
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


    }







}