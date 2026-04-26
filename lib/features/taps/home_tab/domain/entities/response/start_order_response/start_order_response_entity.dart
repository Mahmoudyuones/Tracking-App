import 'start_order_entity.dart';

class StartOrderResponseEntity {
  final String message;
  final StartOrderEntity order;

  StartOrderResponseEntity({required this.message, required this.order});
}
