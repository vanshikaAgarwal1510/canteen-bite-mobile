

class OTPAuthenticateResponse {
  final int status;
  final String message;
  final dynamic data;

  OTPAuthenticateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OTPAuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return OTPAuthenticateResponse(
      status: json['status'],
      message: json['message'],
      data:(json['data']),
    );
  }
//  Order.fromJson

}
