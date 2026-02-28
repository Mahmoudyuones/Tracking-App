import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class BaseState<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final bool? isEmpty;

  const BaseState({this.data, this.errorMessage, this.isEmpty});

  BaseState<T> copyWith({T? data, String? errorMessage, bool? isEmpty}) {
    return BaseState<T>(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  String toString() {
    if (kDebugMode) {
      return 'BaseState(data: $data ,errorMessage: $errorMessage, isEmpty: $isEmpty)';
    }
    return 'BaseState(errorMessage: $errorMessage, isEmpty: $isEmpty)';
  }

  @override
  List<Object?> get props => [data, errorMessage, isEmpty];
}
