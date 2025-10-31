class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  ApiException({
    required this.message,
    this.statusCode,
    this.error,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException({String? message})
      : super(
          message: message ?? 'No internet connection',
          statusCode: null,
        );
}

class TimeoutException extends ApiException {
  TimeoutException()
      : super(
          message: 'Request timeout',
          statusCode: 408,
        );
}

class ServerException extends ApiException {
  ServerException({required int statusCode, String? message})
      : super(
          message: message ?? 'Server error occurred',
          statusCode: statusCode,
        );
}

class UnauthorizedException extends ApiException {
  UnauthorizedException()
      : super(
          message: 'Unauthorized access',
          statusCode: 401,
        );
}
