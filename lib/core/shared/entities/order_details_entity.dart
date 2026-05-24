import 'driver_details_entity.dart';
import 'order_data_entity.dart';

class OrderDetailsEntity {
  final OrderDataEntity orders;
  final DriverDetailEntity driver;

  OrderDetailsEntity({OrderDataEntity? orders, DriverDetailEntity? driver})
    : orders = orders ?? OrderDataEntity(),
      driver = driver ?? DriverDetailEntity();
}
