import 'package:by_hand/models/productModel.dart';
import 'package:by_hand/models/rate.dart';
import 'package:by_hand/providers/interface_provider.dart';

import 'api_helper.dart';

class RateProvider implements SuperProvider<Rates>{
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<Rates> create(Rates object) async {

  }

  @override
  bool destory(int id) {
    // TODO: implement destory
    throw UnimplementedError();
  }

  @override
  Future<List<Rates>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Rates> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Rates> update(Rates object) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future createNew(Rates object) async {
    try {
      final response = await _helper.post("rates", {
        "product_id": object.productId.toString(),
        "value_rate": object.valueRate.toString(),
        "user_product":object.userproduct.toString(),


      });
      return response;
    } catch (ex) {
      // print(ex);
      throw ex;
    }
  }

  Future getSumRates(int id) async {
    try {
      final response = await _helper
          .get("rates/sum/$id");
      return response;
    } catch (ex) {
      throw ex;
    }
  }




}