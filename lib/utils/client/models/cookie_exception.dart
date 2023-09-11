abstract class CookieException implements Exception {
  CookieException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() {
    return 'CookieException{message: $message, statusCode: $statusCode}';
  }
}
