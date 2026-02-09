sealed class Failure {
  final String message;
  final int? statusCode;

  const Failure({
    this.message = 'An unexpected error occurred',
    this.statusCode,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.statusCode});
}




