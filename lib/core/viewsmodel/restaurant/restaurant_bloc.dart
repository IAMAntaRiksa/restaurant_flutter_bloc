import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/core/services/restaurant/restauran_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';
part 'restaurant_bloc.freezed.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  /// Instance Bloc
  static RestaurantBloc instance(BuildContext context) =>
      BlocProvider.of<RestaurantBloc>(context, listen: false);

  /// Depedency Injection
  final restauratService = locator<RestaurantService>();

  RestaurantBloc() : super(const _Initial()) {
    on<_GetRestaurants>((event, emit) async {
      emit(const _Loading());
      final result = await restauratService.getRestaurants();
      if (result.error == false) {
        emit(_Loaded(result.data!));
      } else {
        debugPrint("error Coneection Bermasalah");
        emit(const _Error());
      }
    });
  }
}
