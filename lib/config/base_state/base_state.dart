import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final T? data;
  final String? errorMessage;

  const BaseState({this.data, this.errorMessage});

  BaseState<T> copyWith({T? data, String? errorMessage}) {
    return BaseState<T>(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [data, errorMessage];
}
