part of 'restaurant_bloc.dart';

@freezed
class RestaurantState with _$RestaurantState {
  const factory RestaurantState.initial() = _Initial;
  const factory RestaurantState.loading() = _Loading;
  const factory RestaurantState.loaded(List<RestaurantModel> restaurants) =
      _Loaded;
  const factory RestaurantState.error() = _Error;
}
