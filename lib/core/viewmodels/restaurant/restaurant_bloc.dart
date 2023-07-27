import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/core/services/restaurant/restauran_service.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';
part 'restaurant_bloc.freezed.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  /// Depedency Injection
  final RestaurantService restauratService = locator<RestaurantService>();

  RestaurantBloc() : super(const _Initial()) {
    on<_GetRestaurants>(
      (event, emit) async {
        emit(const _Loading());
        final result = await restauratService.getRestaurants();
        if (result.error == false) {
          return emit(_Loaded(result.data!));
        } else {
          debugPrint("error Coneection Bermasalah");
          return emit(const _Error());
        }
      },
    );

    on<_GetRestaurantById>(
      (event, emit) async {
        emit(const _Loading());
        final userId = await checkTokken.getUserId();
        final result = await restauratService.getUserById(userId);
        if (result.error == false) {
          return emit(_Loaded(result.data!));
        } else {
          debugPrint("error Coneection Bermasalah");
          return emit(const _Error());
        }
      },
    );
  }
}
