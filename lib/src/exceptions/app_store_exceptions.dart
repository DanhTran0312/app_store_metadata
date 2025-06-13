/// Base exception for app store related errors
class AppStoreException implements Exception {
  final String message;

  AppStoreException(this.message);

  @override
  String toString() => 'AppStoreException: $message';
}

/// Exception thrown when an app is not found
class AppNotFoundException extends AppStoreException {
  AppNotFoundException(super.message);

  @override
  String toString() => 'AppNotFoundException: $message';
}

/// Exception thrown when rate limiting is encountered
class RateLimitException extends AppStoreException {
  final Duration? retryAfter;

  RateLimitException(super.message, {this.retryAfter});

  @override
  String toString() => 'RateLimitException: $message';
}
