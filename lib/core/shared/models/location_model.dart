class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({double? latitude, double? longitude})
    : latitude = latitude ?? 0.0,
      longitude = longitude ?? 0.0;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0.0,
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
