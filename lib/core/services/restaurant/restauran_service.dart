import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/models/api/api_response.dart';
import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/create_restaurant.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/upload_restaurant_image_model.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/restaurant/restaurant_model.dart';

class RestaurantService {
  BaseAPI api;

  RestaurantService(this.api);

  Future<ApiResultList<RestaurantModel>> getRestaurants() async {
    APIResponse response =
        await api.get(api.endpoint.getRestaurants, useToken: false);
    return ApiResultList<RestaurantModel>.fromJson(
      response.data,
      (data) => data.map((e) => RestaurantModel.fromJson(e)).toList(),
      field: "data",
    );
  }

  Future<ApiResult<RestaurantModel>> getRestaurant(int id) async {
    APIResponse response = await api.get("${api.endpoint.getRestaurant}/$id");
    return ApiResult<RestaurantModel>.fromJson(
      response.data,
      (data) => RestaurantModel.fromJson(data),
      field: "data",
    );
  }

  Future<ApiResultList<RestaurantModel>> getUserById(int id) async {
    APIResponse response = await api.get("${api.endpoint.getUserById}=$id");
    return ApiResultList<RestaurantModel>.fromJson(
      response.data,
      (datas) => datas.map((e) => RestaurantModel.fromJson(e)).toList(),
      field: "data",
    );
  }

  Future<Either<String, RestaurantModel>> createRestaurant(
      CreateRestaurantModel model) async {
    APIResponse response = await api.post(
      api.endpoint.createRestaurant,
      data: model.toJson(),
    );
    debugPrint("Data Model 1: ${model.toJson()}");
    debugPrint("Data Model 2: ${model.data.toJson()}");
    if (response.statusCode == 200) {
      return Right(
        RestaurantModel.fromJson(
          response.data!,
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  Future<Either<String, UploadRestaurantImageModel>> uploadImage(
      XFile image) async {
    final file = await MultipartFile.fromFile(image.path, filename: image.name);

    final formData = FormData.fromMap({
      'files': file,
    });

    final Dio dio = Dio();
    final token = await checkTokken.getTokenUser();
    Response response = await dio.post(api.endpoint.uploadImageRestaurant,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));

    if (response.statusCode == 200) {
      return Right(UploadRestaurantImageModel.fromJson(response.data[0]));
    } else {
      return const Left('API ERROR');
    }
  }
}
