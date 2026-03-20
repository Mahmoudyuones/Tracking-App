class VehicleTypeEntity {
  final String id;
  final String type;

  const VehicleTypeEntity({required this.id, required this.type});

  static const List<VehicleTypeEntity> vehicleTypes = [
    VehicleTypeEntity(id: '676b63c99f3884b3405c149b', type: 'Motor Cycle'),
    VehicleTypeEntity(id: '676b63ef9f3884b3405c14a5', type: 'Compact'),
    VehicleTypeEntity(id: '676b63fc9f3884b3405c14ad', type: 'Sedan'),
    VehicleTypeEntity(id: '676b640e9f3884b3405c14b5', type: 'Semi'),
    VehicleTypeEntity(id: '676b641c9f3884b3405c14bd', type: 'Sports'),
    VehicleTypeEntity(id: '676b64279f3884b3405c14c5', type: 'SUV'),
    VehicleTypeEntity(id: '676b64349f3884b3405c14cd', type: 'Truck'),
  ];
}
