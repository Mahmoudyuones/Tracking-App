// sealed class BaseResponse<T> {
//   const BaseResponse();
//
//   bool get isSuccess => this is SuccessResponse<T>;
//
//   bool get isError => this is ErrorResponse<T>;
//
//   T? get data =>
//       this is SuccessResponse<T> ? (this as SuccessResponse<T>).data : null;
//
//   Failure? get failure =>
//       this is ErrorResponse<T> ? (this as ErrorResponse<T>).failure : null;
// }

import '../failure/failure.dart';

sealed class BaseResponse<T> {
  const BaseResponse();

  // Original when method
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onError,
  }) {
    return switch (this) {
      SuccessResponse(data: final d) => onSuccess(d),
      ErrorResponse(failure: final f) => onError(f),
    };
  }

  // 🆕 Optional when (doesn't require both handlers)
  R? whenOrNull<R>({
    R Function(T data)? onSuccess,
    R Function(Failure failure)? onError,
  }) {
    return switch (this) {
      SuccessResponse(data: final d) => onSuccess?.call(d),
      ErrorResponse(failure: final f) => onError?.call(f),
    };
  }

  // 🆕 Map success data
  BaseResponse<R> map<R>(R Function(T data) transform) {
    return when(
      onSuccess: (data) => SuccessResponse(transform(data)),
      onError: (failure) => ErrorResponse(failure),
    );
  }

  // 🆕 FlatMap for chaining async operations
  Future<BaseResponse<R>> flatMap<R>(
    Future<BaseResponse<R>> Function(T data) transform,
  ) async {
    return await when(
      onSuccess: (data) => transform(data),
      onError: (failure) => Future.value(ErrorResponse<R>(failure)),
    );
  }

  // 🆕 Convenience getters
  bool get isSuccess => this is SuccessResponse<T>;

  bool get isError => this is ErrorResponse<T>;

  T? get dataOrNull => whenOrNull(onSuccess: (data) => data);

  Failure? get failureOrNull => whenOrNull(onError: (failure) => failure);
}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;

  const SuccessResponse(this.data);
}

class ErrorResponse<T> extends BaseResponse<T> {
  final Failure failure;

  const ErrorResponse(this.failure);
}
