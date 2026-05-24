import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'start_order_details_state.dart';

class StartOrderDetailsCubit extends Cubit<StartOrderDetailsState> {
  StartOrderDetailsCubit() : super(StartOrderDetailsInitial());
}
