import {  Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class Notifications extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

    }
  };
  Notifications.init({
   
   
    title:DataTypes.STRING,
    body:DataTypes.STRING,
   

    deleted_at: 'destroyTime'
  }, {
    sequelize,
    tableName:'notifications',
    paranoid: true,
    modelName: 'Notifications',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: 'deleted_at',
  });
  return Notifications;
};