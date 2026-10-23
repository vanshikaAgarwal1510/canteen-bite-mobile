import 'OrderItems.dart';

class OrderModel {
  final int id;
  final DateTime orderDate;
  final int status;
  final double totalAmount;
  final double? discount;
  final double? subTotal;
  final String paymentStatus;
  final int orderType;
  final List<OrderItems> items;
  final String? pickupCode;
  final bool requirePickupCode;
  final int userId;
  final String userName;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.paymentStatus,
    required this.orderType,
    required this.items,
    required this.pickupCode,
    required this.requirePickupCode,
    required this.userId,
    required this.userName,
    this.discount,
    this.subTotal,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['orderId'] as int,
      orderDate: DateTime.parse(json['orderDate'] as String),
      status: json['status'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      paymentStatus: json['paymentStatus'] as String,
      orderType: json['orderType'] as int,
      pickupCode: json['pickupCode'] as String?,
      requirePickupCode: json['requirePickupCode'] as bool,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItems.fromJson(
        item as Map<String, dynamic>,
      ))
          .toList(),
    );
  }
}