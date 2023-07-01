import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/models/api/api_response.dart';
import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import '../../models/restaurant/restaurant_model.dart';

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
}
