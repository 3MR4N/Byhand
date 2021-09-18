import { Model } from 'sequelize';

const PROTECTED_ATTRIBUTES = ['password'];

export default (sequelize, DataTypes) => {
  class User extends Model {
    toJSON() {
      // hide protected fields
      const attributes = { ...this.get() };
      // eslint-disable-next-line no-restricted-syntax
      for (const a of PROTECTED_ATTRIBUTES) {
        delete attributes[a];
      }
      return attributes;
    }


    static associate(models) {
      // define association here
      User.hasMany(models.Products,{foreignKey:"user_id"})
      User.hasMany(models.Favorites,{foreignKey:"user_id"})
      User.belongsTo(models.TypeUser,{foreignKey:"type_id"})


    }
  };
  User.init({
    address: DataTypes.STRING,
    phone: {
      type: DataTypes.STRING,
    },
    password: DataTypes.STRING,
    email: {
      type: DataTypes.STRING,
      allowNull: {
        args: false,
        msg: 'Please enter your email address',
      },
      unique: {
        args: true,
        msg: 'Email already exists',
      },
      validate: {
        isEmail: {
          args: true,
          msg: 'Please enter a valid email address',
        },
      },
    }, 
    fname: DataTypes.STRING,
    lname: DataTypes.STRING,
    jop: DataTypes.STRING,
    hobe: DataTypes.STRING,
    image_url: DataTypes.STRING,
    deletedAt: 'destroyTime'

  }, {
    paranoid: true,
    sequelize,
    modelName: 'User',
  });
  return User;
};