/// Custom exceptions for the Nexus Training Tracker application
class NexusException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  NexusException({required this.message, this.code, this.originalException});

  @override
  String toString() => message;
}

class AuthenticationException extends NexusException {
  AuthenticationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'AUTH_ERROR',
         originalException: originalException,
       );
}

class AuthorizationException extends NexusException {
  AuthorizationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'PERMISSION_DENIED',
         originalException: originalException,
       );
}

class NetworkException extends NexusException {
  NetworkException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'NETWORK_ERROR',
         originalException: originalException,
       );
}

class ServerException extends NexusException {
  final int? statusCode;

  ServerException({
    required String message,
    String? code,
    this.statusCode,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'SERVER_ERROR',
         originalException: originalException,
       );
}

class DataException extends NexusException {
  DataException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'DATA_ERROR',
         originalException: originalException,
       );
}

class ValidationException extends NexusException {
  final List<String> errors;

  ValidationException({
    required String message,
    required this.errors,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'VALIDATION_ERROR',
         originalException: originalException,
       );
}

class CacheException extends NexusException {
  CacheException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'CACHE_ERROR',
         originalException: originalException,
       );
}
