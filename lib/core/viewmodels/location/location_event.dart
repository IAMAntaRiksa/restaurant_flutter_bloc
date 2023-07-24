part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.started() = _Started;
  const factory LocationEvent.getCurrentLocation() = _GetCurrentLocation;
  const factory LocationEvent.getSelectPosition(double lat, double long) =
      _GetSelectPosition;
}
