import '../../model/Category.dart';
import '../../model/PaymentMethod.dart';

class PaymentMethodResponse {

  late int status;
  late String message;
  List<PaymentMethod>? data;

  PaymentMethodResponse();

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    PaymentMethodResponse response = PaymentMethodResponse();

    response.status = json['status'];
    response.message = json['message'];
    if (json['data'] != null) {
      response.data = (json['data'] as List)
          .map((e) => PaymentMethod.fromJson(e))
          .toList();
    }

    return response;
  }
}




