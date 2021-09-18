import 'dart:convert';

import 'package:by_hand/models/product.dart';

class CategoryModel{
  int id;
  String name;
  String image;
  List<Products> product;

  CategoryModel();

  CategoryModel.fromJson(Map<String,dynamic>json){
    this.id=json['id'];
    this.name=json['name'];
    this.image=json['image_url'];
    // ignore: deprecated_member_use
    this.product = [];
    if (json['Products'] != null) {
      for (var item in json['Products']) {
        product.add(Products.fromJson(item));
      }
    }
  }

  Map<String,dynamic> toJson()=>{
    'id':id,
    'name':name,
    'image_url':image,
    'Products':jsonEncode(product!=null?product.map((e) => e.toJson()).toList():null)

  };
}