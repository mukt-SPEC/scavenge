import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static const _reset = '\x1B[0m';
  static const _red = '\x1B[31m';
  static const _blue = '\x1B[34m';

  static void info(String message) {
    if (kDebugMode) log('$_blue 💡 [INFO] ==> $message$_reset');
  }

  static void error(String message) {
    if (kDebugMode) log('$_red 🚨 [ERROR] ==> $message$_reset', level: 1500);
  }
}
