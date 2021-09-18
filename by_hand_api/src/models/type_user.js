import {  BOOLEAN, INTEGER, Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class TypeUser extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      TypeUser.hasMany(models.User,{foreignKey:"type_id"})


    }
  };
  TypeUser.init({
   
   
    type:DataTypes.STRING,
    count_posts:DataTypes.INTEGER,
    vip_account:BOOLEAN,

    deletedAt: 'destroyTime'
  }, {
    sequelize,
    tableName:'type_user',
    paranoid: true,
    modelName: 'TypeUser',
    
  });
  return TypeUser;
};