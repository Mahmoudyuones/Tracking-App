import 'package:easy_localization/easy_localization.dart';

class ExceptionConstantMessages {
  ExceptionConstantMessages._();

  // App Exception Errors
  static String get invalidEmailOrPassword =>
      'appexceptionerrors.invalidEmailOrPassword'.tr();

  static String get userAccountNotFound =>
      'appexceptionerrors.userAccountNotFound'.tr();

  static String get weakPassword => 'appexceptionerrors.weakPassword'.tr();

  static String get emailAlreadyRegistered =>
      'appexceptionerrors.emailAlreadyRegistered'.tr();

  static String get sessionExpired => 'appexceptionerrors.sessionExpired'.tr();

  static String get authenticationFailed =>
      'appexceptionerrors.authenticationFailed'.tr();

  static String get cashError => 'appexceptionerrors.casherror'.tr();

  static String get databaseError => 'appexceptionerrors.databaseerror'.tr();

  static String get fileError => 'appexceptionerrors.fileerror'.tr();

  static String get networkError => 'appexceptionerrors.networkerror'.tr();

  static String get timeout => 'appexceptionerrors.timeout'.tr();

  static String get unexpectedError =>
      'appexceptionerrors.unexpectedError'.tr();

  static String get validationError =>
      'appexceptionerrors.validationerror'.tr();

  // Server Errors
  static String get badRequest400 => 'servererrors.400_badRequest'.tr();

  static String get unauthorized401 => 'servererrors.401_unauthorized'.tr();

  static String get paymentRequired402 =>
      'servererrors.402_paymentRequired'.tr();

  static String get forbidden403 => 'servererrors.403_forbidden'.tr();

  static String get notFound404 => 'servererrors.404_notFound'.tr();

  static String get methodNotAllowed405 =>
      'servererrors.405_methodNotAllowed'.tr();

  static String get notAcceptable406 => 'servererrors.406_notAcceptable'.tr();

  static String get requestTimeout408 => 'servererrors.408_requestTimeout'.tr();

  static String get conflict409 => 'servererrors.409_conflict'.tr();

  static String get gone410 => 'servererrors.410_gone'.tr();

  static String get payloadTooLarge413 =>
      'servererrors.413_payloadTooLarge'.tr();

  static String get unsupportedMediaType415 =>
      'servererrors.415_unsupportedMediaType'.tr();

  static String get unprocessableEntity422 =>
      'servererrors.422_unprocessableEntity'.tr();

  static String get tooManyRequests429 =>
      'servererrors.429_tooManyRequests'.tr();

  static String get internalServerError500 =>
      'servererrors.500_internalServerError'.tr();

  static String get notImplemented501 => 'servererrors.501_notImplemented'.tr();

  static String get badGateway502 => 'servererrors.502_badGateway'.tr();

  static String get serviceUnavailable503 =>
      'servererrors.503_serviceUnavailable'.tr();

  static String get gatewayTimeout504 => 'servererrors.504_gatewayTimeout'.tr();

  static String get defaultServerError => 'servererrors.default'.tr();
}
