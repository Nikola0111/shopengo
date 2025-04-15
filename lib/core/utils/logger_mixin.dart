import 'dart:developer';

import 'package:flutter/foundation.dart';

enum _LogSeverity { info, debug, warning, error }

mixin LoggerMixin {
  abstract final String className;

  void logD(String message) {
    _printWithSeverity(_LogSeverity.debug, '$className: $message');
  }

  void logI(String message) {
    _printWithSeverity(_LogSeverity.info, '$className: $message');
  }

  void logW(String message) {
    _printWithSeverity(_LogSeverity.warning, '$className: $message');
  }

  void logE(String message, {String? debugText}) {
    _printWithSeverity(_LogSeverity.error, '$className: $message', debugText: debugText);
  }

  static void logDebug(String name, String message) {
    _printWithSeverity(_LogSeverity.debug, '$name: $message');
  }

  static void logInfo(String name, String message) {
    _printWithSeverity(_LogSeverity.debug, '$name: $message');
  }

  static void logWarning(String name, String message) {
    _printWithSeverity(_LogSeverity.debug, '$name: $message');
  }

  static void logError(String name, String message, {String? debugText}) {
    _printWithSeverity(_LogSeverity.debug, '$name: $message');
  }

  static void _printWithSeverity(_LogSeverity severity, String message, {String? debugText}) {
    var output = '${DateTime.now()}: $message';
    if (debugText != null) {
      output += ', error: $debugText';
    }
    // don't print if it's prod
    if (kDebugMode) {
      // ignore: avoid_print
      print(output);
    }
    log(output);
  }
}
