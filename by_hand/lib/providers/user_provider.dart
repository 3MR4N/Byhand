import 'package:by_hand/models/message.dart';
import 'package:by_hand/models/user.dart';
import 'package:by_hand/providers/interface_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_helper.dart';

class UserProvider implements SuperProvider<Users> {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<Users> create(Users object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future destroyUser(int id) async {
    try {
      var res = await _helper.delete('users/$id');

      return res;
    } catch (ex) {
      print(ex);
    }
  }

  @override
  bool destory(int id) {
    // TODO: implement destory
    throw UnimplementedError();
  }

  @override
  Future<List<Users>> getAll() async {
    try {
      List<Users> myModels = [];
      var response =
          await _helper.get("users");

      if (response != null) {
        response.forEach((v) {
          myModels.add( Users.fromJson(v));
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
  Future<Users> getById(int id) async {
    try {
      final response = await _helper.get("users/$id");
      return Users.fromJson(response);
    } catch (ex) {
      throw ex;
    }
  }

  @override
  Future<Users> update(Users object) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<Users> login(String email, String password) async {
    try {
      final response = await _helper.post("users/login", {"email": email, "password": password});
      return Users.fromJson(response);
    } catch (ex) {
      print("44");
      throw ex;
    }
  }

  Future signIn(
    String email,
    String password,
    String fname,
    String lname,
    String address,
    String phone,
  ) async {
    try {
      final response = await _helper.post("users/register", {
        'address': address,
        'phone': phone,
        'password': password,
        'email': email,
        'fname': fname,
        'lname': lname,
      });
      return response;
    } catch (ex) {
      return "Please enter a valid email address";
    }
  }

  Future editUser(int type, int id) async {
    {
      try {
        final response = await _helper.put("users/type/$id", {
          "type_id":type.toString(),
        });
        return response;
      } catch (ex) {
        print("44");
        return ex;
      }
    }
  }

  asyncFileUpload(String email, String password, String fname, String lname,
      String address, String phone, File file, int id) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "PUT", Uri.parse("http://192.168.1.73:9009/product/image/user/$id"));
    //add text fields
    request.fields["fname"] = fname.toString();
    request.fields["email"] = email.toString();
    request.fields["password"] = password.toString();
    request.fields["phone"] = phone.toString();
    request.fields["lname"] = lname.toString();
    request.fields["address"] = address.toString();

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
