class CartItem {
  final int itemId;
  final String itemName;
  final double price;
  final String? imageUrl;
  final int quantity;
  final double averageRating;
  final String? itemDescription;

  const CartItem({
    required this.itemId,
    required this.itemName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.averageRating = 0.0,
    this.itemDescription,
  });

  // Create an updated copy of the cart item
  CartItem copyWith({int? quantity}) {
    return CartItem(
      itemId: itemId,
      itemName: itemName,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
      averageRating: averageRating,
      itemDescription: itemDescription,
    );
  }

  // Total price for this item
  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'itemName': itemName,
    'price': price,
    'imageUrl': imageUrl,
    'quantity': quantity,
    'averageRating': averageRating,
    'itemDescription': itemDescription,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: (json['itemId'] as num).toInt(),
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      itemDescription: json['itemDescription'] as String?,
    );
  }
}
