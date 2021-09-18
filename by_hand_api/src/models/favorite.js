import { Model } from 'sequelize';


export default (sequelize, DataTypes) => {
  class Favorites extends Model {
   
    static associate(models) {
      // define association here

      Favorites.belongsTo(models.Products,{foreignKey:"product_id"})
      Favorites.belongsTo(models.User,{foreignKey:"user_id"})


    }
  };
  Favorites.init({
    product_id: DataTypes.INTEGER,
    user_id: DataTypes.INTEGER,
    deletedAt: 'destroyTime'

  }, {
    paranoid: true,
    sequelize,
    tableName:'favorite',
    modelName: 'Favorites',
  });
  return Favorites;
};