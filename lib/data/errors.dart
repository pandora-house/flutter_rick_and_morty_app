class StatusException implements Exception {
  const StatusException({this.message});

  final message;

  @override
  String toString() => 'Server response $message';
}

class NoInternetException implements Exception {
  @override
  String toString() => 'Socket connection';
}

class NoServiceFoundException implements Exception {
  @override
  String toString() => 'No Service Found';
}

class InvalidFormatException implements Exception {
  @override
  String toString() => 'Invalid Data Format';
}

class UnknownException implements Exception {
  @override
  String toString() => 'Unknown exception';
}