import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  StoreModel({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
