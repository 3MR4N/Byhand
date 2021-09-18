import {  INTEGER, Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class Notes extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

    }
  };
  Notes.init({
   
   
    title:DataTypes.STRING,
    details:DataTypes.STRING,
    account_id:INTEGER,

    deleted_at: 'destroyTime'
  }, {
    sequelize,
    tableName:'notes',
    paranoid: true,
    modelName: 'Notes',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: 'deleted_at',
  });
  return Notes;
};