import '../exception/exception_handler.dart';
import '../base_response/base_response.dart';

Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return BaseResponse<T>.success(response);
  } catch (error, stackTrace) {
    final appException = ExceptionHandler.handle(
      exception: error,
      stackTrace: stackTrace,
    );
    ExceptionHandler.logException(appException);
    return BaseResponse<T>.failure(appException);
  }
}
