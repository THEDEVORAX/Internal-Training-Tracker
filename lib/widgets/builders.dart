import 'package:flutter/material.dart';

/// Builder widget for handling Result states with loading, error, and success
class ResultBuilder<T> extends StatelessWidget {
  final dynamic result;
  final Widget Function(T data) onSuccess;
  final Widget Function(String error) onError;
  final Widget Function() onLoading;

  const ResultBuilder({
    Key? key,
    required this.result,
    required this.onSuccess,
    required this.onError,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return result.when(
      success: (data) => onSuccess(data),
      error: (error) => onError(error),
      loading: () => onLoading(),
    );
  }
}

/// Async snapshot builder with better error handling
class AsyncSnapshotBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) onSuccess;
  final Widget Function(String error) onError;
  final Widget Function() onLoading;

  const AsyncSnapshotBuilder({
    Key? key,
    required this.future,
    required this.onSuccess,
    required this.onError,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading();
        } else if (snapshot.hasError) {
          return onError(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return onSuccess(snapshot.data as T);
        } else {
          return onError('No data available');
        }
      },
    );
  }
}
