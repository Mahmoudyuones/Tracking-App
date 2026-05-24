import 'location_entity.dart';

class OrderDataEntity {
  final String id;
  final UserDataEntity user;
  final List<OrderItemsEntity> orderItems;
  final int totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;
  final StoreEntity store;

  OrderDataEntity({
    String? id,
    UserDataEntity? user,
    List<OrderItemsEntity>? orderItems,
    int? totalPrice,
    String? paymentType,
    bool? isPaid,
    bool? isDelivered,
    String? state,
    String? createdAt,
    String? updatedAt,
    String? orderNumber,
    StoreEntity? store,
  }) : id = id ?? '',
       user = user ?? UserDataEntity(),
       orderItems = orderItems ?? [],
       totalPrice = totalPrice ?? 0,
       paymentType = paymentType ?? '',
       isPaid = isPaid ?? false,
       isDelivered = isDelivered ?? false,
       state = state ?? '',
       createdAt = createdAt ?? '',
       updatedAt = updatedAt ?? '',
       orderNumber = orderNumber ?? '',
       store = store ?? StoreEntity();
}

class UserDataEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final LocationEntity location;

  UserDataEntity({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? phone,
    String? photo,
    LocationEntity? location,
  }) : id = id ?? '',
       firstName = firstName ?? '',
       lastName = lastName ?? '',
       email = email ?? '',
       gender = gender ?? '',
       phone = phone ?? '',
       photo = photo ?? '',
       location = location ?? LocationEntity();
}

class OrderItemsEntity {
  final ProductEntity product;
  final int price;
  final int quantity;
  final String id;

  OrderItemsEntity({
    ProductEntity? product,
    int? price,
    int? quantity,
    String? id,
  }) : product = product ?? ProductEntity(),
       price = price ?? 0,
       quantity = quantity ?? 0,
       id = id ?? '';
}

class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final int discount;
  final int sold;

  ProductEntity({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? quantity,
    String? category,
    String? occasion,
    String? createdAt,
    String? updatedAt,
    int? discount,
    int? sold,
  }) : id = id ?? '',
       title = title ?? '',
       slug = slug ?? '',
       description = description ?? '',
       imgCover = imgCover ?? '',
       images = images ?? [],
       price = price ?? 0,
       priceAfterDiscount = priceAfterDiscount ?? 0,
       quantity = quantity ?? 0,
       category = category ?? '',
       occasion = occasion ?? '',
       createdAt = createdAt ?? '',
       updatedAt = updatedAt ?? '',
       discount = discount ?? 0,
       sold = sold ?? 0;
}

class StoreEntity {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  StoreEntity({
    String? name,
    String? image,
    String? address,
    String? phoneNumber,
    String? latLong,
  }) : name = name ?? '',
       image = image ?? '',
       address = address ?? '',
       phoneNumber = phoneNumber ?? '',
       latLong = latLong ?? '';
}
