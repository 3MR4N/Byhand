import model from '../models';
const moment = require('moment');

import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Notifications } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const notifications = await Notifications.findAll({
               
                order: [
                    ['id', 'DESC'],
                ],
            
            });
            notifications.map((notification)=>{
                notification.dataValues.createdAt= moment(notification.created_at).format('YYYY-MM-DD')
                console.log(notification.dataValues.createdAt)

            })

            res.json(notifications);
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
            const notification = await Notifications.findOne({
                where: {
                    id: req.params.id
                }
            })
            if (notification) {
                return res.json(notification);
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
            title,
            body,
          

        } = req.body;
        try {
            await Notifications.create({
                title,
                body,
                 
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
            title,
            body,
          
            
        } = req.body;

        try {
            const notification = await Notifications.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (notification) {
                await Notifications.update({
                    title,
            body,
                  

                    
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
            const notification = await Notifications.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (notification) {
                await Notifications.destroy({
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