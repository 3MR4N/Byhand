import { Model } from 'sequelize';


export default (sequelize, DataTypes) => {
  class Categorys extends Model {

    static associate(models) {
      // define association here
      Categorys.hasMany(models.Products,{foreignKey:"category_id"})

    }
  };
  Categorys.init({
    name: DataTypes.STRING,
    image_url:DataTypes.STRING,
    deletedAt: 'destroyTime'

  }, {
    paranoid: true,
    sequelize,
    tableName:'category',
    modelName: 'Categorys',
  });
  return Categorys;
};