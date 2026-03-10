class ShowErrorException implements Exception {

  final String? message;

  ShowErrorException([this.message]);

  @override
  String toString() => message!;
}