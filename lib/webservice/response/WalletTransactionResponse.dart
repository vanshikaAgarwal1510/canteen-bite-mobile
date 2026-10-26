import 'package:canteen_bite_mobile/model/WalletTransaction.dart';

import '../../model/Category.dart';
import '../../model/PaymentMethod.dart';

class WalletTransactionResponse {

  late int status;
  late String message;
  List<WalletTransaction>? data;

  WalletTransactionResponse();

  factory WalletTransactionResponse.fromJson(Map<String, dynamic> json) {
    WalletTransactionResponse response = WalletTransactionResponse();

    response.status = json['status'];
    response.message = json['message'];
    if (json['data'] != null) {
      response.data = (json['data'] as List)
          .map((e) => WalletTransaction.fromJson(e))
          .toList();
    }

    return response;
  }
}




