import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_order_state_state.dart';

class UpdateOrderStateCubit extends Cubit<UpdateOrderStateState> {
  UpdateOrderStateCubit() : super(UpdateOrderStateInitial());
}
