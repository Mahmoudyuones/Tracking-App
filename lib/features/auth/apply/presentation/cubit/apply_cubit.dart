import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../../domain/usecases/apply_use_case.dart';
import 'apply_intents.dart';
import 'apply_side_effects.dart';
import 'apply_state.dart';

class ApplyCubit extends Cubit<ApplyState> {
  final ApplyUseCase applyUseCase;
  ApplyCubit(this.applyUseCase) : super(const ApplyState());

  final StreamController<ApplySideEffects> _sideEffectsController =
      StreamController<ApplySideEffects>.broadcast();

  Stream<ApplySideEffects> get sideEffects => _sideEffectsController.stream;

  void doIntent(ApplyIntents intent) {
    switch (intent) {
      case SubmitApplyIntent(request: final request):
        _doApply(request);
    }
  }

  void _doApply(ApplyRequestEntity request) async {
    _sideEffectsController.add(ApplyLoading());
    final response = await applyUseCase(request);
    response.when(
      success: (successMessage) {
        emit(state.copyWith(applyState: BaseState(data: successMessage)));
        _sideEffectsController.add(NavigateToSuccessApply());
      },
      failure: (failure) {
        emit(
          state.copyWith(applyState: BaseState(errorMessage: failure.message)),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
