import { Op } from 'sequelize';
import model from '../models';
const bcrypt = require('bcrypt');
const saltRounds = 10;
const { User } = model;

export default {
    async findOne(req, res) {
        try {

            const user = await User.findOne({
                include:[
                    model.TypeUser
                ],
                where: {
                    id: req.params.id
                }
            })

            if (user) {
                return res.json(user);
            } else {
                return res.status(404).json({
                    message: "user not found"
                });
            }

        } catch (ex) {
            console.log(ex);
            res.status(500).json({
                message: localeController.translate("Could_not_perform"),
            });
        }},

    async signUp(req, res) {
        var { email, password, fname,lname,address, phone } = req.body;
        try {
            const user = await User.findOne({  where: {
                email: email
            }   });
            if (user) {
                return res.status(404).json({ message: 'User with that email Already exists Login Now' });
            }
            password = bcrypt.hashSync(password, saltRounds);


            await User.create({
                fname,
                email,
                password,
                phone,
                lname,
                address,
            });
            return res.status(200).json({ message: 'Account created successfully' });
        } catch (err) {
            console.log(err);
            return res.status(500).json(
                    { message: 'Could not perform operation at this time, kindly try again later.' });
        }
    },
    async login(req, res) {
        try {
            var email = req.body.email;
            var password = req.body.password
            const user = await User.findOne({
                include:[model.TypeUser],
                where: { email: email},
            })
            
            if (user) {
                var result = bcrypt.compareSync(password, user.password);
                console.log(result);
                if (result) {
                    return res.json(user);
                }else{
                    return res.status(404).json({
                        message: "Password is incorrect",
                    });
                }

            }
            return res.status(404).json({
                message: "not_found",
            });
        } catch (ex) {
            console.log(ex);
            res.status(500).json({
                message: "Could_not_perform",
            });
        }

    },
    async findAll(req, res) {
        try {
            const user = await User.findAll({
                include:[
                    model.TypeUser
                ]
            });
            res.json(user);
        } catch (ex) {
            console.log(ex)
            return res.status(500).json({
                message: 'Could not perform operation at this time, kindly try again later.'
            })
        }
    },
    async update(req, res) {
        var  image_url=req.file.path;
        image_url=image_url.replace("\\","/");
        const {
            fname,
                email,
                password,
                phone,
                lname,
                address,

        } = req.body;

        try {
            const user = await User.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (user) {
                await User.update({
                    fname,
                    email,
                    password,
                    phone,
                    lname,
                    image_url,
                    address,
                }, {

                    where: {
                        id: req.params.id
                    }
                });
                return res.status(200).json({
                    message: 'User updated successfully'
                });
            } else {
                return res.status(404).json({
                    message: "User not found"
                });
            }
        } catch (ex) {
            console.log(ex);
            return res.status(500).json({
                    message: 'Could not perform operation at this time, kindly try again later.'
                });

        }

    },

    async updateType(req, res) {
       
        const {
            type_id

        } = req.body;

        try {
            const user = await User.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (user) {
                await User.update({
                    type_id
                }, {

                    where: {
                        id: req.params.id
                    }
                });
                return res.status(200).json({
                    message: 'User updated successfully'
                });
            } else {
                return res.status(404).json({
                    message: "User not found"
                });
            }
        } catch (ex) {
            console.log(ex);
            return res.status(500).json({
                    message: 'Could not perform operation at this time, kindly try again later.'
                });

        }

    },
    async destroy(req, res) {
        try {
            const user = await User.findOne({
                where: {
                    id: req.params.id
                }
            });
            if (user) {
                await User.destroy({
                    where: {
                        id: req.params.id
                    }
                });
                return res.status(200).json({
                    message: "User has been deleted!"
                });

            } else {
                return res.status(404).json({
                    message: "User Not Found"
                });
            }

        } catch (ex) {
            console.log(ex);
            return res.status(500)
                .json({
                    message: 'Could not perform operation at this time, kindly try again later.'
                });

        }


    }

}