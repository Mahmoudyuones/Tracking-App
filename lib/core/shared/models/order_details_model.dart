import 'driver_details_model.dart';
import 'order_data_model.dart';

class OrderDetailsModel {
  final OrderDataModel orders;
  final DriverDetailModel driver;

  OrderDetailsModel({OrderDataModel? orders, DriverDetailModel? driver})
    : orders = orders ?? OrderDataModel(),
      driver = driver ?? DriverDetailModel();

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      driver: json['driver'] != null
          ? DriverDetailModel.fromJson(json['driver'])
          : DriverDetailModel(),
      orders: json['orders'] != null
          ? OrderDataModel.fromJson(json['orders'])
          : OrderDataModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'orders': orders.toJson(), 'driver': driver.toJson()};
  }
}
