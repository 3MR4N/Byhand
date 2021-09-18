import 'package:by_hand/models/notifications_model.dart';
import 'api_helper.dart';
import 'interface_provider.dart';

class NotificationsProviders implements SuperProvider{
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future create(object) async {
    try {
      final response = await _helper.post("notifications", {
        "title": object.title.toString(),
        "body": object.body.toString(),
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
  Future<List> getAll() async {
    try {
      List<NotificationsModel> myNotes = [];
      var response =
      await _helper.get("notifications");

      if (response != null) {
        response.forEach((v) {
          myNotes.add(new NotificationsModel.fromJson(v));
        });
      }

      print('888888');

      return myNotes;
    } catch (ex) {
      print(ex);
      throw ex;
    }
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

}