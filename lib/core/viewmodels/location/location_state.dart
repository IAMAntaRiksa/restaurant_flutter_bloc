part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.loaded(GmapModel model) = _Loaded;
  const factory LocationState.error(String error) = _Error;
}
