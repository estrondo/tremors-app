class TremorsException implements Exception {
  final String message;
  final dynamic cause;

  TremorsException(this.message, [this.cause]);

  @override
  String toString() {
    return (cause == null)
        ? '$runtimeType: $message'
        : '$runtimeType: $message\n\tCaused by $cause';
  }
}

enum SecurityError {
  failedTokenStorage(100);

  final int code;

  const SecurityError(this.code);
}

class SecurityException extends TremorsException {
  final SecurityError? error;

  SecurityException(super.message, [super.cause, this.error]);

  factory SecurityException.fromError(SecurityError error, [dynamic cause]) {
    return SecurityException(error.name, cause, error);
  }
}

class PreferencesException extends TremorsException {
  PreferencesException(super.message, [super.cause]);
}

class ConfigurationException extends TremorsException {
  ConfigurationException(super.message, [super.cause]);
}
