import 'package:by_hand/models/package.dart';

import 'api_helper.dart';
import 'interface_provider.dart';

class PackageProvider implements SuperProvider{

  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  Future create(object) async {
    try {
      final response = await _helper.post("packages", {
        "name": object.name.toString(),
        "price": object.price.toString(),
        "description": object.description.toString(),
      });
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  @override
  bool destory(int id) {
    // TODO: implement destory
    throw UnimplementedError();
  }

  @override
  Future<List> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future update(object) {
    // TODO: implement update
    throw UnimplementedError();
  }


  Future<List> getAllByAccount() async {
    try {
      List<Package> myPackage = [];
      var response =
      await _helper.get("packages");

      if (response != null) {
        response.forEach((v) {
          myPackage.add(new Package.fromJson(v));
        });
      }

      print('888888');

      return myPackage;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }


  Future updatePack(String name,String price,String des,int id) async {
    try {
      final response = await _helper.put("packages/$id", {
        'name': name.toString(),
        'price': price.toString(),
        'description': des.toString()
      });
      return response;
    } catch (ex) {
      throw ex;
    }
  }


}