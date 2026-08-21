import 'package:flutter/foundation.dart';

class Logger {
  static String _timestamp() => DateTime.now().toIso8601String();

  static void info(String tag, String message) {
    if (kDebugMode) {
      debugPrint('LOGGER [${_timestamp()}] [DEBUG] [INFO]  [$tag] $message');
    }
  }

  static void warn(String tag, String message) {
    if (kDebugMode) {
      debugPrint('LOGGER [${_timestamp()}] [DEBUG] [WARN]  [$tag] $message');
    }
  }

  static void error(String tag, String message) {
    if (kDebugMode) {
      debugPrint('LOGGER [${_timestamp()}] [DEBUG] [ERROR] [$tag] $message');
    }
  }
}
