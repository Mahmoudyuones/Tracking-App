import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../domain/entities/driver_response_entity.dart';
import '../../domain/usecases/get_driver_profile_date_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'my_profile_events.dart';
import 'my_profile_state.dart';
import 'my_profile_ui_events.dart';

@injectable
class MyProfileCubit extends Cubit<MyProfileState> {
  final GetDriverProfileDateUsecase _getDriverProfileDateUsecase;
  final LogoutUsecase _logoutUsecase;
  MyProfileCubit(this._getDriverProfileDateUsecase, this._logoutUsecase)
    : super(
        MyProfileState(
          myProfileState: const BaseState<DriverResponseEntity>(),
          logoutState: const BaseState<void>(),
        ),
      );

  final _uiEventController = StreamController<MyProfileUiEvent>.broadcast();
  Stream<MyProfileUiEvent> get uiEventStream => _uiEventController.stream;
  void onEvent(MyProfileEvent event) {
    switch (event) {
      case GetDriverProfileDataEvent():
        _getDriverProfileDate();
      case ChangeLanguageEvent():
        _showLanguageBottomSheet();
      case LogoutEvent():
        _showLogoutDialog();
      case ConfirmLogoutEvent():
        _logout();
    }
  }

  Future<void> _getDriverProfileDate() async {
    _uiEventController.add(LoadingUiEvent());
    final response = await _getDriverProfileDateUsecase.call();
    response.when(
      success: (driverResponseEntity) {
        _uiEventController.add(
          SuccessUiEvent(driverResponseEntity: driverResponseEntity),
        );
        emit(
          state.copyWith(
            myProfileState: BaseState<DriverResponseEntity>(
              data: driverResponseEntity,
            ),
          ),
        );
      },
      failure: (appException) {
        _uiEventController.add(ErrorUiEvent(message: appException.message));
        emit(
          state.copyWith(
            myProfileState: BaseState<DriverResponseEntity>(
              errorMessage: appException.message,
            ),
          ),
        );
      },
    );
  }

  void _showLanguageBottomSheet() {
    _uiEventController.add(ShowLanguageBottomSheetEvent());
  }

  void _showLogoutDialog() {
    _uiEventController.add(ShowLogoutDialogEvent());
  }

  Future<void> _logout() async {
    _uiEventController.add(LoadingUiEvent());
    final response = await _logoutUsecase.call();
    response.when(
      success: (_) {
        emit(state.copyWith(logoutState: const BaseState<void>(data: null)));
        _uiEventController.add(LogoutSuccessUiEvent());
      },
      failure: (appException) {
        _uiEventController.add(ErrorUiEvent(message: appException.message));
        emit(
          state.copyWith(
            logoutState: BaseState<void>(errorMessage: appException.message),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
