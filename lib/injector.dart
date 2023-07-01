import 'package:flutter_caffe_ku/core/data/api.dart';
import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/services/auth/auth_service.dart';
import 'package:flutter_caffe_ku/core/services/restaurant/restauran_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(Api());
  locator.registerSingleton(BaseAPI());
  locator.registerLazySingleton(() => RestaurantService(locator<BaseAPI>()));
  locator.registerLazySingleton(() => AuthServices(locator<BaseAPI>()));
}
