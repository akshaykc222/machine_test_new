class CustomException implements Exception {
  final String? _prefix;

  CustomException([this._prefix]);

  @override
  String toString() {
    return _prefix.toString();
  }
}

class NoPinException extends CustomException {
  NoPinException([String? message]) : super(message ?? "No Pin Set");
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException([String? message]) : super(message ?? "Unauthorized");
}
