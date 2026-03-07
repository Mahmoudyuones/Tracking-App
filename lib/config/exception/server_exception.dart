import 'app_exception.dart';
import 'exception_constant_messages.dart';

class ServerException extends AppException {
  final int? statusCode;
  final Map<String, dynamic>? responseData;

  ServerException({
    this.statusCode,
    this.responseData,
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() {
    if (responseData != null) {
      if (responseData!.containsKey('message')) {
        return responseData!['message'] as String;
      }
      if (responseData!.containsKey('error')) {
        return responseData!['error'] as String;
      }
    }
    switch (statusCode) {
      case 400:
        return ExceptionConstantMessages.badRequest400;

      case 401:
        return ExceptionConstantMessages.unauthorized401;

      case 402:
        return ExceptionConstantMessages.paymentRequired402;

      case 403:
        return ExceptionConstantMessages.forbidden403;

      case 404:
        return ExceptionConstantMessages.notFound404;

      case 405:
        return ExceptionConstantMessages.methodNotAllowed405;

      case 406:
        return ExceptionConstantMessages.notAcceptable406;

      case 408:
        return ExceptionConstantMessages.requestTimeout408;

      case 409:
        return ExceptionConstantMessages.conflict409;

      case 410:
        return ExceptionConstantMessages.gone410;

      case 413:
        return ExceptionConstantMessages.payloadTooLarge413;

      case 415:
        return ExceptionConstantMessages.unsupportedMediaType415;

      case 422:
        return ExceptionConstantMessages.unprocessableEntity422;

      case 429:
        return ExceptionConstantMessages.tooManyRequests429;

      case 500:
        return ExceptionConstantMessages.internalServerError500;

      case 501:
        return ExceptionConstantMessages.notImplemented501;

      case 502:
        return ExceptionConstantMessages.badGateway502;

      case 503:
        return ExceptionConstantMessages.serviceUnavailable503;

      case 504:
        return ExceptionConstantMessages.gatewayTimeout504;

      default:
        return ExceptionConstantMessages.defaultServerError;
    }
  }
}
