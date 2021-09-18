import model from '../models';
const moment = require('moment');

import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
const { Notes } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const notess = await Notes.findAll({
               
                order: [
                    ['id', 'DESC'],
                ],
            
            });
            notess.map((notes)=>{
                notes.dataValues.createdAt= moment(notes.created_at).format('YYYY-MM-DD')
                console.log(notes.dataValues.createdAt)

            })

            res.json(notess);
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
            const notes = await Notes.findOne({
                where: {
                    id: req.params.id
                }
            })
            if (notes) {
                return res.json(notes);
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
            details,
            account_id,

        } = req.body;
        try {
            await Notes.create({
                title,
                details,
                account_id,
                 
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
            details,
          
            
        } = req.body;

        try {
            const notes = await Notes.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (notes) {
                await Notes.update({
                    title,
                    details,
                  

                    
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
            const notes = await Notes.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (notes) {
                await Notes.destroy({
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