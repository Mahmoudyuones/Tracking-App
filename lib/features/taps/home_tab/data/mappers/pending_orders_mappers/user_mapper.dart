import '../../../domain/entities/response/pending_orders_response/user_entity.dart';
import '../../models/response/pending_order_response/user_model.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
    );
  }
}
