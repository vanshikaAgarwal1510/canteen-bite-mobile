class MenuItem {
  final int itemId;
  final String itemName;
  final String? itemDescription;
  final double price;
  final bool isAvailable;
  final String? imageUrl;
  final int averageRating;
  final int? categoryID;

  MenuItem({
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.price,
    required this.isAvailable,
    this.imageUrl,
    required this.averageRating,
    required this.categoryID,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      itemId: json['itemId'],
      itemName: json['itemName'],
      itemDescription: json['itemDescription'],
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'],
      imageUrl: json['imageUrl'] ?? "",
      averageRating: json['averageRating'],
      categoryID: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'price': price,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'averageRating': averageRating,
      'categoryId': categoryID,
    };
  }
}
