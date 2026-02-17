import 'package:equatable/equatable.dart';

class OrdersEntity extends Equatable {
  final StoreEntity storeEntity;
  final OrderEntity orderEntity;

  const OrdersEntity({
    this.storeEntity = const StoreEntity(),
    this.orderEntity = const OrderEntity(),
  });

  @override
  List<Object?> get props => [storeEntity, orderEntity];
}

class StoreEntity extends Equatable {
  final String name;
  final String image;
  final String address;

  const StoreEntity({this.name = '', this.image = '', this.address = ''});

  @override
  List<Object?> get props => [name, image, address];
}

class OrderEntity extends Equatable {
  final String id;
  final UserEntity userEntity;
  final int totalPrice;

  const OrderEntity({
    this.id = '',
    this.userEntity = const UserEntity(),
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [id, userEntity, totalPrice];
}

class UserEntity extends Equatable {
  final String name;
  final String image;
  final String address;

  const UserEntity({this.name = '', this.image = '', this.address = ''});

  @override
  List<Object?> get props => [name, image, address];
}
