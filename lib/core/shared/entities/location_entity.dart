class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({double? latitude, double? longitude})
    : latitude = latitude ?? 0.0,
      longitude = longitude ?? 0.0;
}
