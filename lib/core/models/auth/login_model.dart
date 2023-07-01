import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class AuthRespponseModel extends Serializable {
  final String? jwt;
  final User? user;

  AuthRespponseModel({
    required this.jwt,
    required this.user,
  });

  factory AuthRespponseModel.fromJson(Map<String, dynamic> json) {
    return AuthRespponseModel(
      jwt: json['jwt'] ?? "",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "jwt": jwt,
      "user": user,
    };
  }
}

base class User extends Serializable {
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confrimed;
  final bool blocked;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confrimed,
    required this.blocked,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      provider: json['provider'],
      confrimed: json['confrimed'] ?? true,
      blocked: json['blocked'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": email,
      "email": email,
      "provider": provider,
      "confrimed": confrimed,
      "blocked": blocked,
    };
  }
}

base class LoginRequestModel extends Serializable {
  final String identifier;
  final String password;

  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "identifier": identifier,
      "password": password,
    };
  }
}
