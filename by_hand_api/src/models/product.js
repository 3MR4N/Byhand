import { Model } from 'sequelize';


export default (sequelize, DataTypes) => {
  class Products extends Model {
   
     
    static associate(models) {
      // define association here
      Products.belongsTo(models.User,{foreignKey:"user_id"})
      Products.belongsTo(models.Categorys,{foreignKey:"category_id"})


      Products.hasMany(models.Rates,{foreignKey:"product_id"})
      Products.hasOne(models.Favorites,{foreignKey:"product_id"})



    }
  };
  Products.init({
    user_id: DataTypes.INTEGER,
    category_id: DataTypes.INTEGER,
    available: DataTypes.BOOLEAN,
    image1_url:DataTypes.STRING,
    image2_url:DataTypes.STRING,
    name: DataTypes.STRING,
    sub_name: DataTypes.STRING,
    price: DataTypes.STRING,
    description: DataTypes.STRING,
    deletedAt: 'destroyTime'

  }, {
    paranoid: true,
    sequelize,
    tableName:'product',
    modelName: 'Products',
  });
  return Products;
};