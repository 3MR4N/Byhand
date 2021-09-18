import 'package:by_hand/models/favorites.dart';
import 'package:by_hand/models/product.dart';
import 'package:by_hand/providers/interface_provider.dart';

import 'api_helper.dart';

class FavoritesProvider implements SuperProvider {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future create(object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  bool destory(int id) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List> getAll() async {
    // TODO: implement create
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

  Future createNew(Favorites object) async {
    try {
      final response = await _helper.post("favorites", {
        "product_id": object.productId.toString(),
        "user_id": object.userId.toString(),
      });
      return response;
    } catch (ex) {
      // print(ex);
      throw ex;
    }
  }

  Future getAllByUser(int id) async {
    try {
      List<Favorites> myModels = [];
      var response = await _helper.get("favorites/user/$id");

      if (response != null) {
        response.forEach((v) {
          if(v['Product']!=null){
            v['Product']['price']=v['Product']['price'].toString();
            myModels.add(Favorites.fromJson(v));

          }
        });
      }

      return myModels;
    } catch (ex) {
      print(ex);
      print('88888888888888888888888888888888888888888888888');
      throw ex;
    }
  }

  Future deleteFav(int id) async {
    try {
      var res = await _helper.delete('favorites/$id');

      return res;
    } catch (ex) {
      print(ex);
    }
  }
}
