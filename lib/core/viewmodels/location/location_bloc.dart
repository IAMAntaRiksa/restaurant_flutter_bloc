import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/gmap_model.dart';
import 'package:flutter_caffe_ku/core/utils/location/location_utils.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  /// Depndency Injection
  final utilsLocation = locator<LocationUtils>();

  LocationBloc() : super(const _Initial()) {
    on<_GetCurrentLocation>((event, emit) async {
      emit(const _Loading());
      final result = await utilsLocation.getCurrentPosition();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetSelectPosition>((event, emit) async {
      final result =
          await utilsLocation.getPosition(lat: event.lat, long: event.long);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
