/// Generic result wrapper for API calls
abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(String error) error,
    required R Function() loading,
  });
}

class SuccessResult<T> extends Result<T> {
  final T data;

  const SuccessResult(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) error,
    required R Function() loading,
  }) => success(data);
}

class ErrorResult<T> extends Result<T> {
  final String error;

  const ErrorResult(this.error);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) error,
    required R Function() loading,
  }) => error(this.error);
}

class LoadingResult<T> extends Result<T> {
  const LoadingResult();

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) error,
    required R Function() loading,
  }) => loading();
}
