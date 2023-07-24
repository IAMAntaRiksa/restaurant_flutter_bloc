part of 'create_restaurant_bloc.dart';

@freezed
class CreateRestaurantEvent with _$CreateRestaurantEvent {
  const factory CreateRestaurantEvent.started() = _Started;
  const factory CreateRestaurantEvent.createRestaurant(
      CreateRestaurantModel model, XFile image) = _CreateRestaurant;
}
