import 'dart:convert';

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
import 'package:http/http.dart' as http;

class RestaurantService {
  BaseAPI api;

  RestaurantService(this.api);

  Future<ApiResultList<RestaurantModel>> getRestaurants() async {
    APIResponse response = await api.get(api.endpoint.getRestaurants);
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
      useToken: true,
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

    APIResponse response = await api.post(
      api.endpoint.uploadImageRestaurant,
      data: formData,
      useToken: true,
    );
    if (response.statusCode == 200) {
      return Right(
        UploadRestaurantImageModel.fromJson(
          jsonDecode(response.data![0]),
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  // Future<Either<String, UploadRestaurantImageModel>> uploadImage(
  //     XFile image) async {
  //   final token = await checkTokken.getTokenUser();
  //   final header = <String, String>{
  //     'Authorization': 'Bearer $token',
  //   };
  //   final request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(api.endpoint.uploadImageRestaurant),
  //   );

  //   final bytes = await image.readAsBytes();

  //   final multiPartFile =
  //       http.MultipartFile.fromBytes('files', bytes, filename: image.name);

  //   request.files.add(multiPartFile);
  //   request.headers.addAll(header);

  //   http.StreamedResponse response = await request.send();

  //   final responseList = await response.stream.toBytes();
  //   final String responseData = String.fromCharCodes(responseList);

  //   if (response.statusCode == 200) {
  //     return Right(
  //         UploadRestaurantImageModel.fromJson(jsonDecode(responseData)[0]));
  //   } else {
  //     return const Left('error upload image');
  //   }
  // }
}
