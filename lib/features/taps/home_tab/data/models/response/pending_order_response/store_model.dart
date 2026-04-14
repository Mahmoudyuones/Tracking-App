import 'package:freezed_annotation/freezed_annotation.dart';
part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  @JsonKey(name: 'latLong')
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
