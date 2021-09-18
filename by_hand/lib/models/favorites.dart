import 'package:by_hand/models/product.dart';

class Favorites{
  int id;
  int userId;
  int productId;
  Products products;

  Favorites();

  Favorites.fromJson(Map<String,dynamic> json){
    this.id=json['id'];
    this.userId=json['user_id'];
    this.productId=json['product_id'];
    products = Products.fromJson(json['Product']);
  }
}