
import 'package:accounts/data/failure/failure.dart';
import 'package:accounts/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';

extension FailureTypeLocalizationX on BuildContext {
  String toLocalize(FailureType failureType) {
    switch (failureType) {
      case FailureType.dioConnectTimeout:
        return l10n.errorDioConnectTimeout;
      case FailureType.dioReceiveTimeOut:
        return l10n.errorDioReceiveTimeout;
      case FailureType.dioSendTimeOut:
        return l10n.errorDioSendTimeout;
      case FailureType.connection:
        return l10n.errorConnection;
      case FailureType.dioBadCertificate:
      case FailureType.jsonParse:
      case FailureType.dioCancel:
      case FailureType.other:
      case FailureType.badRequest:
      case FailureType.unAuthorized:
      case FailureType.payment:
      case FailureType.forbidden:
      case FailureType.notFound:
      case FailureType.intervalServer:
      case FailureType.badGateway:
      case FailureType.unknown:
      case FailureType.secureStorage:
      case FailureType.persistentStorage:
      case FailureType.memoryStorage:
      case FailureType.fileSystem:
        return l10n.errorSystem(failureType.code);
      case FailureType.dateFormat:
        return l10n.errorDateFormat;
      case FailureType.identityFormat:
        return l10n.errorFailureFormat;
    }
  }
}
