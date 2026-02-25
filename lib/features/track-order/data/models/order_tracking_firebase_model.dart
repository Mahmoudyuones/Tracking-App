import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_firebase_model.dart';
import 'shipping_address_model.dart';
import 'store_model.dart';
import 'user_info_model.dart';

part 'order_tracking_firebase_model.g.dart';

@JsonSerializable()
class OrderTrackingFirebaseModel {
  final String orderId;
  final String orderNumber;
  final String state;
  final num totalPrice;
  final String paymentType;
  final UserInfoModel user;
  final ShippingAddressModel? shippingAddress;
  final StoreModel store;
  final List<OrderItemFirebaseModel> orderItems;

  OrderTrackingFirebaseModel({
    required this.orderId,
    required this.orderNumber,
    required this.state,
    required this.totalPrice,
    required this.paymentType,
    required this.user,
    this.shippingAddress,
    required this.store,
    required this.orderItems,
  });

  factory OrderTrackingFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingFirebaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTrackingFirebaseModelToJson(this);

  factory OrderTrackingFirebaseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderTrackingFirebaseModel.fromJson(data);
  }
}
