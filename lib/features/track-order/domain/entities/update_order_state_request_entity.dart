import 'package:equatable/equatable.dart';

class UpdateOrderStateRequestEntity extends Equatable {
  final String state;
  const UpdateOrderStateRequestEntity({required this.state});

  @override
  List<Object?> get props => [state];
}
