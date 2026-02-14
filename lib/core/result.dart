sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure? failure;
  const Error(this.failure);
}

class Failure {
  final String? message;
  final StackTrace? stackTrace;

  const Failure(this.message, this.stackTrace);
}
