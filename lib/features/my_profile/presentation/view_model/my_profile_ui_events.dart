import '../../domain/entities/driver_response_entity.dart';

sealed class MyProfileUiEvent {}

class LoadingUiEvent extends MyProfileUiEvent {}

class ErrorUiEvent extends MyProfileUiEvent {
  final String message;
  ErrorUiEvent({required this.message});
}

class SuccessUiEvent extends MyProfileUiEvent {
  final DriverResponseEntity driverResponseEntity;
  SuccessUiEvent({required this.driverResponseEntity});
}

class ShowLanguageBottomSheetEvent extends MyProfileUiEvent {}

class ShowLogoutDialogEvent extends MyProfileUiEvent {}
