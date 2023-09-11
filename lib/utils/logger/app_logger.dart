import 'package:easy_logger/easy_logger.dart';

class AppLogger {
  AppLogger._init() {
    _logger = EasyLogger(
      enableBuildModes: [BuildMode.debug, BuildMode.profile],
      name: 'Stilus',
    );
  }
  static late final EasyLogger _logger;

  static AppLogger? _instance;

  static AppLogger getInstance() => _instance ??= AppLogger._init();

  static void logInfo(String message, {StackTrace? stackTrace}) {
    _logger.info(message);
  }

  static void logWarning(String message, {StackTrace? stackTrace}) {
    _logger.warning(message);
  }

  static void logDebug(String message, {StackTrace? stackTrace}) {
    _logger.debug(message);
  }

  static void logError(String message, {StackTrace? stackTrace}) {
    _logger.error(message, stackTrace: stackTrace);
  }
}
