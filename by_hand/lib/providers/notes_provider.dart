import 'package:by_hand/models/notes.dart';

import 'api_helper.dart';
import 'interface_provider.dart';

class NotesProviders implements SuperProvider{

  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  Future create(object) async {
    try {
      final response = await _helper.post("notes", {
        "title": object.title.toString(),
        "details": object.details.toString(),
        "account_id": object.accountId.toString(),
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


  Future<List> getAllByAccount(int id) async {
    try {
      List<Notes> myNotes = [];
      var response =
      await _helper.get("notes");

      if (response != null) {
        response.forEach((v) {
          myNotes.add(new Notes.fromJson(v));
        });
      }

      print('888888');

      return myNotes;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }


}