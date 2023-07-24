import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/core/services/restaurant/restauran_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_restaurant_event.dart';
part 'detail_restaurant_state.dart';
part 'detail_restaurant_bloc.freezed.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  /// Instance Bloc
  static DetailRestaurantBloc instance(BuildContext context) =>
      BlocProvider.of<DetailRestaurantBloc>(context, listen: false);

  /// Dependency Injection
  final restauratService = locator<RestaurantService>();
  DetailRestaurantBloc() : super(const _Initial()) {
    on<_GetRestaurant>((event, emit) async {
      emit(const _Loading());
      final result = await restauratService.getRestaurant(event.id);
      if (result.error == false) {
        emit(_Loaded(result.data!));
      } else {
        emit(const _Error("Error"));
      }
    });
  }
}
