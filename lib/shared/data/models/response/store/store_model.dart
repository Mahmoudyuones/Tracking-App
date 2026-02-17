import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'latLong')
  final String? latLong;

  const StoreModel({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  @override
  List<Object?> get props => [name, image, address, phoneNumber, latLong];
}
