import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class RegisterModel extends Serializable {
  final String name;
  final String username;
  final String email;
  final String password;

  RegisterModel({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
    };
  }
}
