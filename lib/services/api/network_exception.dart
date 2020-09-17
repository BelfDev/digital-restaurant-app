/// Base exception for network-related errors.
class _NetworkException implements Exception {
  final _message;
  final _prefix;

  _NetworkException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends _NetworkException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends _NetworkException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends _NetworkException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends _NetworkException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
