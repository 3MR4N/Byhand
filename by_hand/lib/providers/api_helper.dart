import 'dart:io';
import 'package:by_hand/models/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_ex.dart';

class ApiBaseHelper {

 //final String _baseUrl = "http://192.168.1.8:9009/";
  final String _baseUrl = "http://192.168.1.73:9009/";
  final String imageServer = "http://192.168.1.73:9009/";


  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print(_baseUrl + url);
      final response = await http.get(_baseUrl + url);
      print(response);
      responseJson = _returnResponse(response);
    } catch (err) {
      print(err);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response =
      await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response =
      await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      var responseJson = json.decode(response.body.toString());
      Message message = Message.fromJson(responseJson);
      throw message.message;
    case 404:
      var responseJson = json.decode(response.body.toString());
      Message message = Message.fromJson(responseJson);
      throw message.message;
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error while Communication with Server with StatusCode : ${response.statusCode}');
  }
}