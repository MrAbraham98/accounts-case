enum FailureType {
  jsonParse(1),
  dioCancel(2),
  dioBadCertificate(3),
  dioConnectTimeout(4),
  dioReceiveTimeOut(5),
  dioSendTimeOut(6),
  connection(7),
  other(8),
  badRequest(9),
  unAuthorized(10),
  payment(11),
  forbidden(12),
  notFound(13),
  intervalServer(14),
  badGateway(15),
  unknown(16),
  secureStorage(18),
  persistentStorage(19),
  memoryStorage(20),
  fileSystem(21),
  dateFormat(22),
  identityFormat(23);

  const FailureType(this.code);

  final int code;

}

final class Failure implements Exception {
  Failure({
    this.message,
    this.statusCode,
    this.description,
    required this.failureType,
  });

  final String? message;
  final int? statusCode;
  final String? description;
  final FailureType failureType;

  @override
  String toString() {
    return 'Failure{message: $message, statusCode: $statusCode, '
        'description: $description, failureType: $failureType}';
  }
}
