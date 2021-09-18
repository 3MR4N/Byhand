import model from '../models';
const moment = require('moment');

import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Package } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const packageesss = await Package.findAll({

                order: [
                    ['id', 'DESC'],
                ],

            });
            // packageesss.map((packageess) => {
            //     packageess.dataValues.createdAt = moment(packageess.created_at).format('YYYY-MM-DD')
            //     console.log(packageess.dataValues.createdAt)

            // })

            res.json(packageesss);
        } catch (ex) {
            console.log(ex)
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },

    async findOne(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const packageess = await Package.findOne({
                where: {
                    id: req.params.id
                }
            })
            if (packageess) {
                return res.json(packageess);
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
            name,
            price,
            description,

        } = req.body;
        try {
            await Package.create({
                name,
                price,
                description,

            });
            return res.json({
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
            price,
            description,


        } = req.body;

        try {
            const packageess = await Package.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (packageess) {
                await Package.update({
                    name,
                    price,
                    description,


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
            const packageess = await Package.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (packageess) {
                await Package.destroy({
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
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            });

        }


    }







}