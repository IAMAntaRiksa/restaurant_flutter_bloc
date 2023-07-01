import 'package:dartz/dartz.dart';
import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/models/api/api_response.dart';
import 'package:flutter_caffe_ku/core/models/auth/login_model.dart';
import 'package:flutter_caffe_ku/core/models/auth/register_model.dart';

class AuthServices {
  BaseAPI api;

  AuthServices(this.api);

  Future<Either<String, AuthRespponseModel>> login(
      LoginRequestModel model) async {
    APIResponse response = await api.post(
      api.endpoint.loginResturant,
      data: model.toJson(),
      useToken: true,
    );

    if (response.statusCode == 200) {
      return Right(
        AuthRespponseModel.fromJson(response.data!),
      );
    } else {
      return const Left(
        'Password Dan Email Salah!, Silakan Coba login ulang',
      );
    }
  }

  Future<Either<String, AuthRespponseModel>> register(
      RegisterModel model) async {
    APIResponse response = await api.post(
      api.endpoint.registerResturant,
      data: model.toJson(),
      useToken: true,
    );

    if (response.statusCode == 200) {
      return Right(
        AuthRespponseModel.fromJson(response.data!),
      );
    } else {
      return const Left(
        'Register Gagal Perikasa Koneksi!',
      );
    }
  }
}
