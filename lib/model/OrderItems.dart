class OrderItems {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;
  final int averageRating;


  OrderItems({
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
     this.imageUrl,
    required this.averageRating,

  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      id: json['itemId'] as int,
      name: json['itemName'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? "",
      averageRating: json['averageRating'] as int,
    );
  }
}