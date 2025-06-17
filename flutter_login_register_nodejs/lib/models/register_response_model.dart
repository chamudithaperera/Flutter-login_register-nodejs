import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  late final String message;
  late final Data? data;

  RegisterResponseModel({required this.message, required this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = this.message;
    _data['data'] = this.data!.toJson();
    return _data;
  }
}

class Data {
  late final String username;
  late final String email;
  late final String date;
  late final String id;

  Data({
    required this.username,
    required this.email,
    required this.date,
    required this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['email'] = this.email;
    _data['date'] = this.date;
    _data['id'] = this.id;
    return _data;
  }
}
