import {  INTEGER, Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class Package extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

    }
  };
  Package.init({
   
   
    name:DataTypes.STRING,
    price:DataTypes.STRING,
    description:DataTypes.STRING,

    deletedAt: 'destroyTime'
  }, {
    sequelize,
    tableName:'package',
    paranoid: true,
    modelName: 'Package',
    
  });
  return Package;
};