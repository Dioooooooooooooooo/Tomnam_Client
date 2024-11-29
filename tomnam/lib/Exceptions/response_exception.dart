class ResponseException implements Exception {
  final String message;
  final String error;
  final int statusCode;

  ResponseException(this.message, this.error, this.statusCode);

  @override
  String toString() => message;
}