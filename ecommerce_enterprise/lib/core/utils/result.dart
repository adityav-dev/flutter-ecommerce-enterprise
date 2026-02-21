import '../error/failures.dart';

/// Result type for use case returns: either success [T] or [Failure].
/// Enables explicit error handling without exceptions in the domain layer.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isError => this is Error<T>;
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Failure? get failureOrNull => this is Error<T> ? (this as Error<T>).failure : null;
}
