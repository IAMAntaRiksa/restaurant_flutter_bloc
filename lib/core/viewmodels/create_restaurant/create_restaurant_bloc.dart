import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/create_restaurant.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/core/services/restaurant/restauran_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'create_restaurant_event.dart';
part 'create_restaurant_state.dart';
part 'create_restaurant_bloc.freezed.dart';

class CreateRestaurantBloc
    extends Bloc<CreateRestaurantEvent, CreateRestaurantState> {
  /// Instance Bloc
  static CreateRestaurantBloc instance(BuildContext context) =>
      BlocProvider.of(listen: false, context);

  /// Depedency Injection
  final restaurantService = locator<RestaurantService>();

  CreateRestaurantBloc() : super(const _Initial()) {
    on<_CreateRestaurant>((event, emit) async {
      emit(const _Loading());
      final uploadResult = await restaurantService.uploadImage(event.image);
      await Future.sync(
        () => uploadResult.fold(
          (errorUpload) => emit(_Error(errorUpload)),
          (successUpload) async {
            final result = await restaurantService.createRestaurant(
                CreateRestaurantModel(
                    data: event.model.data.copyWith(
                        photo:
                            'http://103.150.116.14:1337 ${successUpload.urlImage}')));
            result.fold(
              (l) => emit(_Error(l)),
              (r) => emit(_Loaded(r)),
            );
          },
        ),
      );
    });
  }
}
