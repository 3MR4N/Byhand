import 'dart:io';

import 'package:by_hand/models/category.dart';
import 'package:by_hand/providers/interface_provider.dart';
import 'package:http/http.dart' as http;

import 'api_helper.dart';

class CategoriesProvisers implements SuperProvider<CategoryModel>{
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<CategoryModel> create(CategoryModel object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  bool destory(int id) {
    // TODO: implement destory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getAll() async {
      try {
        List<CategoryModel> myModels = [];
        var response =
        await _helper.get("category");

        if (response != null) {
          response.forEach((v) {
            myModels.add( CategoryModel.fromJson(v));
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
  Future<CategoryModel> getById(int id) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> update(CategoryModel object) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future getByIdCate(int id) async {
    try {
      CategoryModel aa;
      final response = await _helper
          .get("category/$id");
      aa=CategoryModel.fromJson(response);
      print('${aa.product} getByIdCategetByIdCategetByIdCategetByIdCate');
      return aa;
    } catch (ex) {
      print('000000000000000000000000000000000000000000000000');
      print(ex);
      throw ex;
    }
  }

  asyncFileUpload(String name, File file) async{
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("http://192.168.1.73:9009/product/image/cate/"));
    //add text fields
    request.fields["name"] = name.toString();

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


}