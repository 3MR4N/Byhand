import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/interface_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_helper.dart';

class ProductProvider implements SuperProvider<Products>{
  ApiBaseHelper _helper = ApiBaseHelper();

@override
  Future<Products> create(Products object) async {
  try {
    final response = await _helper.post("products", {
      "name": object.name.toString(),
      "sub_name": object.subName.toString(),
      "price": object.price.toString(),
      "description": object.description.toString(),
      "category_id":object.categoryId.toString(),
      "user_id":object.userId.toString()

    });
    return response;
  } catch (ex) {
    // print(ex);
    throw ex;
  }
  }

  @override
  bool destory(int id) {
    // TODO: implement destory
    throw UnimplementedError();
  }

  @override
  Future<List<Products>> getAll() async {

    try {
      List<Products> myModels = [];
      var response =
          await _helper.get("products");

      if (response != null) {
        response.forEach((v) {
          myModels.add( Products.fromJson(v));
        });
      }

      print('888888');

      return myModels;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }

  @override
  Future<Products> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Products> update(Products object) {
    // TODO: implement update
    throw UnimplementedError();
  }
  asyncFileUpload(Products object, File file) async{
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://192.168.1.73:9009/product/image"));
    //add text fields
    request.fields["name"] = object.name.toString();
    request.fields["sub_name"] = object.subName.toString();
    request.fields["price"] = object.price.toString();
    request.fields["description"] = object.description.toString();
    request.fields["category_id"] = object.categoryId.toString();
    request.fields["user_id"] = object.userId.toString();

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("photos", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  Future createNew(Products object,File image) async {
    try {
      final response = await _helper.post("/product/image", {
        "name": object.name.toString(),
        "sub_name": object.subName.toString(),
        "price": object.price.toString(),
        "description": object.description.toString(),
        "category_id":object.categoryId.toString(),
        "user_id":object.userId.toString(),
        "photos":image.path.split("/").last

      });
      return response;
    } catch (ex) {
      // print(ex);
      throw ex;
    }
  }

  Future updatePro(Products object,int id) async {
    try {
      final response = await _helper.put("products/$id", {
        "name": object.name.toString(),
        "sub_name": object.subName.toString(),
        "price": object.price.toString(),
        "description": object.description.toString(),
        "category_id":object.categoryId.toString(),
        "user_id":object.userId.toString()

      });
      return response;
    } catch (ex) {
      // print(ex);
      throw ex;
    }
  }

  Future<List<Products>> getAllByuser(int id) async {

    try {
      List<Products> myModels = [];
      var response =
      await _helper.get("products/user/$id");

      if (response != null) {
        response.forEach((v) {
          myModels.add( Products.fromJson(v));
        });
      }

      print('888888');

      return myModels;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }

  Future deleteFav(int id) async {
    try {
      var res = await _helper.delete('products/$id');

      return res;
    } catch (ex) {
      print(ex);
    }
  }

  Future getAllCount(int id) async {

    try {
      var response =
      await _helper.get("products/product_user/$id");

      return response;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }



}