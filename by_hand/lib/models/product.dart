import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products{
  int id;
  int userId;
  int categoryId;
  bool available;
  bool favorite;
  String image1;
  String image2;
  String name;
  String subName;
  String price;
  String description;
  String type;
  String rates;


  Products();

  Products.fromJson(Map<String,dynamic> json){
    this.id=json['id'];
    this.userId=json['user_id'];
    this.categoryId=json['category_id'];
    this.available=json['available'];
    this.image1=json['image1_url'];
    this.image2=json['image2_url'];
    this.name=json['name'];
    this.subName=json['sub_name'];
    this.price=json['price'];
    this.description=json['description'];
    this.type=json['type'];
    this.rates=json['rates'];

  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'category_id': categoryId,
    'available': available,
    'image1_url': image1,
    'image2_url': image2,
    'name': name,
    'sub_name': subName,
    'price': price,
    'description': description,
    'type': type,

  };
}