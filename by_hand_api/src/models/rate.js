import { Model } from 'sequelize';


export default (sequelize, DataTypes) => {
  class Rates extends Model {
    
    static associate(models) {
      // define association here
      Rates.belongsTo(models.Products,{foreignKey:"product_id"})

    }
  };
  Rates.init({
    product_id: DataTypes.INTEGER,
    value_rate: DataTypes.DOUBLE,
    user_product:DataTypes.STRING,
    deletedAt: 'destroyTime'

  }, {
    paranoid: true,
    sequelize,
    tableName:'rate',
    modelName: 'Rates',
  });
  return Rates;
};