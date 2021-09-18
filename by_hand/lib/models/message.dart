import 'dart:convert';

class Message {
  String message;

  Message();

  Message.fromJson(Map<String, dynamic> json)
  {
    this.message = json['message'];
  }

  Map<String, dynamic> toJson() => {
    'message': message,
  };
}