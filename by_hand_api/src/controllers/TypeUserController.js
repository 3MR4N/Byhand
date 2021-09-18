import model from '../models';
const moment = require('moment');

import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { TypeUser } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const typeUsers = await TypeUser.findAll({

                order: [
                    ['id', 'DESC'],
                ],

            });
    
            res.json(typeUsers);
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
            const typeUser = await TypeUser.findOne({
                where: {
                    id: req.params.id
                }
            })
            if (typeUser) {
                return res.json(typeUser);
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
            type,
                    count_posts,
                    vip_account,

        } = req.body;
        try {
            await TypeUser.create({
                type,
                    count_posts,
                    vip_account,

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
            type,
                    count_posts,
                    vip_account,


        } = req.body;

        try {
            const typeUser = await TypeUser.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (typeUser) {
                await TypeUser.update({
                    type,
                    count_posts,
                    vip_account,


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
            const typeUser = await TypeUser.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (typeUser) {
                await TypeUser.destroy({
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