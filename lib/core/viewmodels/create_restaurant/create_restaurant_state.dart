part of 'create_restaurant_bloc.dart';

@freezed
class CreateRestaurantState with _$CreateRestaurantState {
  const factory CreateRestaurantState.initial() = _Initial;
  const factory CreateRestaurantState.loading() = _Loading;
  const factory CreateRestaurantState.loaded(RestaurantModel model) = _Loaded;
  const factory CreateRestaurantState.error(String message) = _Error;
}
