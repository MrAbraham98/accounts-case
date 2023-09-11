import 'package:accounts/data/failure/failure.dart';
import 'package:dio/dio.dart';

class FailureExceptionHandler {
  FailureExceptionHandler.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.badCertificate:
        error = Failure(failureType: FailureType.dioBadCertificate);
        break;
      case DioExceptionType.cancel:
        error = Failure(failureType: FailureType.dioCancel);
        break;

      case DioExceptionType.connectionTimeout:
        error = Failure(failureType: FailureType.dioConnectTimeout);
        break;

      case DioExceptionType.receiveTimeout:
        error = Failure(failureType: FailureType.dioReceiveTimeOut);
        break;

      case DioExceptionType.sendTimeout:
        error = Failure(failureType: FailureType.dioSendTimeOut);
        break;

      case DioExceptionType.connectionError:
        error = Failure(failureType: FailureType.connection);
        break;

      case DioExceptionType.badResponse:
        error = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;

      case DioExceptionType.unknown:
        if (dioError.error.toString().contains('SocketException')) {
          error = Failure(failureType: FailureType.connection);
          break;
        } else if (dioError.error
                .toString()
                .contains('CertificateNotVerifiedException') ||
            dioError.error
                .toString()
                .contains('CertificateCouldNotBeVerifiedException')) {
          error = Failure(failureType: FailureType.dioBadCertificate);
          break;
        } else {
          error = Failure(
              failureType: FailureType.other,
              description: dioError.error.toString(),);
          break;
        }
      default:
        error = Failure(failureType: FailureType.other);
        break;
    }
  }

  late Failure error;

  Failure _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return Failure(failureType: FailureType.badRequest);
      case 401:
        return Failure(failureType: FailureType.unAuthorized);
      case 403:
        return Failure(failureType: FailureType.forbidden);
      case 404:
        return Failure(
          failureType: FailureType.notFound,
          description: error.toString(),
        );
      case 500:
        return Failure(failureType: FailureType.intervalServer);
      case 502:
        return Failure(failureType: FailureType.badGateway);
      default:
        return Failure(failureType: FailureType.other);
    }
  }
}
