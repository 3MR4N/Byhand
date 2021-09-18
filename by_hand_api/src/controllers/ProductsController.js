import model from '../models';
import {
    Op
} from 'sequelize';
import {
    LocaleController
} from './LocaleController';
import RatesController from './RatesController';
const { Products,Favorites } = model;
const localeController = new LocaleController();

export default {

    async findAll(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const product = await Products.findAll({
            
            });
            // product.map((products)=>{
            //     products.price=parseFloat(products.price).toFixed(3);

            // });
            res.json(product);
        } catch (ex) {
            console.log(ex);
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },



    async findOne(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const product = await Products.findOne({
                include:[model.Rates],
                where: {
                    id: req.params.id
                }
            })
            if (product) {
                return res.json(product);
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

        var  image1_url=req.file.path;
        image1_url=image1_url.replace("\\","/");
        const {
            user_id,
            category_id,
            available,
            image2_url,
            name,
            sub_name,
            price,
            description,

        } = req.body;
        try {
            await Products.create({
                user_id,
                category_id,
                available,
                image1_url,
                image2_url,
                name,
                sub_name,
                price,
                description,
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

            available,
            category_id,
            name,
            sub_name,
            price,
            description,
        } = req.body;

        try {
            const product = await Products.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (product) {
                await Products.update({
                    available,
                    name,
                    sub_name,
                    price,
                    description,
                    category_id,

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
            const product = await Products.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (product) {
                await Products.destroy({
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

    async findAllUser(req, res) {
        localeController.setLocale(req.headers.language);
        try {
            const product = await Products.findAll({
                include:[
                    model.Rates
                ],
                where:{
                    user_id:req.params.id
                }
            });
            // product.map((products)=>{
            //     products.price=parseFloat(products.price).toFixed(3);

            // });
            product.map((products)=>{
                products.Rates.map((rate)=>{
                    products.dataValues.rates=parseFloat(rate.value_rate).toFixed(2)

                })
            })
            res.json(product);
        } catch (ex) {
            return res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            })
        }
    },

    async productsUser(req,res){
      try {
        const product = await Products.count({
            
            where:{
                user_id:req.params.id
            }
          });
          return res.json(product);

      } catch (error) {
          console.log(error)
        return res.status(500).json({
            message: localeController.translate("Could_not_perform"),
        })
      }
    }









}