class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "No Internet connection available, Please try again"]);

  @override
  String toString() => message;
}