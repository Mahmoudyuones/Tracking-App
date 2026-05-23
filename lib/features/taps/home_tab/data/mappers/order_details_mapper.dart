import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../../../../../core/shared/entities/location_entity.dart';
import '../../../../../core/shared/entities/order_data_entity.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../../../../../core/shared/models/driver_details_model.dart';
import '../../../../../core/shared/models/location_model.dart';
import '../../../../../core/shared/models/order_data_model.dart';
import '../../../../../core/shared/models/order_details_model.dart';

extension OrderDetailsMapper on OrderDetailsEntity {
  OrderDetailsModel toModel() {
    return OrderDetailsModel(
      orders: orders.toModel(),
      driver: driver.toModel(),
    );
  }
}

extension OrderDetailsModelMapper on OrderDetailsModel {
  OrderDetailsEntity toEntity() {
    return OrderDetailsEntity(
      orders: orders.toEntity(),
      driver: driver.toEntity(),
    );
  }
}

extension OrderDataMapper on OrderDataEntity {
  OrderDataModel toModel() {
    return OrderDataModel(
      id: id,
      user: user.toModel(),
      orderItems: orderItems.map((e) => e.toModel()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      store: store.toModel(),
    );
  }
}

extension OrderDataModelMapper on OrderDataModel {
  OrderDataEntity toEntity() {
    return OrderDataEntity(
      id: id,
      user: user.toEntity(),
      orderItems: orderItems.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      store: store.toEntity(),
    );
  }
}

extension UserDataMapper on UserDataEntity {
  UserDataModel toModel() {
    return UserDataModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      location: location.toModel(),
    );
  }
}

extension UserDataModelMapper on UserDataModel {
  UserDataEntity toEntity() {
    return UserDataEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      location: location.toEntity(),
    );
  }
}

extension OrderItemsMapper on OrderItemsEntity {
  OrderItemsModel toModel() {
    return OrderItemsModel(
      product: product.toModel(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension OrderItemsModelMapper on OrderItemsModel {
  OrderItemsEntity toEntity() {
    return OrderItemsEntity(
      product: product.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

extension ProductMapper on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      discount: discount,
      sold: sold,
    );
  }
}

extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      discount: discount,
      sold: sold,
    );
  }
}

extension StoreMapper on StoreEntity {
  StoreModel toModel() {
    return StoreModel(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}

extension StoreModelMapper on StoreModel {
  StoreEntity toEntity() {
    return StoreEntity(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}

extension DriverDetailMapper on DriverDetailEntity {
  DriverDetailModel toModel() {
    return DriverDetailModel(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nID: nID,
      nIDImg: nIDImg,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      createdAt: createdAt,
      location: location.toModel(),
    );
  }
}

extension DriverDetailModelMapper on DriverDetailModel {
  DriverDetailEntity toEntity() {
    return DriverDetailEntity(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nID: nID,
      nIDImg: nIDImg,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      createdAt: createdAt,
      location: location.toEntity(),
    );
  }
}

extension LocationMapper on LocationEntity {
  LocationModel toModel() {
    return LocationModel(latitude: latitude, longitude: longitude);
  }
}

extension LocationModelMapper on LocationModel {
  LocationEntity toEntity() {
    return LocationEntity(latitude: latitude, longitude: longitude);
  }
}
