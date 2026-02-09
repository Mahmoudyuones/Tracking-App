import '../../core/utility/exception_handler.dart';
import '../base_response/base_response.dart';

Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final result = await apiCall();
    return SuccessResponse(result);
  } catch (e, stackTrace) {
    final appException = ExceptionHandler.handle(
      exception: e,
      stackTrace: stackTrace,
    );
    ExceptionHandler.logException(appException);
    return ErrorResponse(appException.toFailure());
  }
}

/// -----------------------------------------------------------
///                       safeAPiCall Mechanism
/// -----------------------------------------------------------
/// 1) In Case SuccessResponse =>  Return Data
/// 2) In Case ErrorResponse => Return Error Message
///     1. Convert raw error to a domain-specific AppException
///     2. Log it for debugging/Crashlytics
///     3. Map the Exception to a UI-friendly Failure and return
