class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void logError(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.live) {
      print("Error: $data$stackTrace");
    }
  }

  static void logInfo(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.live) {
      print("Info: $data$stackTrace");
    }
  }

  static void logDebug(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      print("Debug: $data$stackTrace");
    }
  }
}

enum LogMode { debug, live }
