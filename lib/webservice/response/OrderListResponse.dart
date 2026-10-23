import 'package:canteen_bite_mobile/model/Order.dart';

class OrderListResponse {
  int status;
  String message;
  List<OrderModel> orders;


  OrderListResponse({
    required this.status,
    required this.message,
    required this.orders,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {

    List<OrderModel> orderss = [];


    if (json['data'] != null) {

      if (json['data'] != null) {
        orderss = (json['data'] as List)
            .map((e) => OrderModel.fromJson(e))
            .toList();
      }
    }

    return OrderListResponse(
      status: json['status'],
      message: json['message'],
      orders: orderss,
    );
  }

}