class MenuItem {
  final int itemId;
  final String itemName;
  final String itemDescription;
  final double price;
  final bool isAvailable;
  final String? imageUrl;
  final double averageRating;

  MenuItem({
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.price,
    required this.isAvailable,
    this.imageUrl,
    required this.averageRating,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      itemId: json['itemId'],
      itemName: json['itemName'],
      itemDescription: json['itemDescription'],
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'],
      imageUrl: json['imageUrl'],
      averageRating: json['averageRating'],
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
    };
  }
}

var menu = {
  "status": 200,
  "message": "Menu fetched successfully",
  "data": [
    {
      "categoryId": 1,
      "categoryName": "Snack",
      "categoryDescription":
          "Quick bites and light snacks, perfect for any time cravings.",
      "imageUrl":
          "https://media.istockphoto.com/id/1156130293/photo/group-of-gujarati-snacks-like-jalebi-fafda-thepla-khaman-dhokla-aloo-bhujiya-khandvi-khakra.webp?s=1024x1024&w=is&k=20&c=v0gz5XpttvzQfpMJvPJtnUXUZ0rMk_Tip47-sxJ1aE8=",
      "items": [
        {
          "itemId": 2,
          "itemName": "Vada Pav",
          "itemDescription": "Classic Mumbai-style vada pav served with spicy chutneys.",
          "price": 30.0,
          "isAvailable": true,
          "imageUrl":
              "https://media.istockphoto.com/id/1329213718/photo/vada-pav.webp?s=1024x1024&w=is&k=20&c=KKqmaK-vOGWzXcDJiwiNIsZSnVfKZIt0FWiFZRxKJ60=",
          "averageRating": 4,
        },
        {
          "itemId": 3,
          "itemName": "Dhokla",
          "itemDescription": "Soft and fluffy steamed dhokla with mild spices.",
          "price": 25.0,
          "isAvailable": true,
          "imageUrl":
              "https://media.istockphoto.com/id/522927649/photo/indian-breakfast-khaman-dhokla.webp?s=1024x1024&w=is&k=20&c=wxYUaIG2uWeV5nN0LRWN7lzzeRkbwsuEXfWHZooikSY=",
          "averageRating": 4.2,
        },
        {
          "itemId": 4,
          "itemName": "Burger",
          "itemDescription": "Freshly made burger with a crispy patty and tasty sauces.",
          "price": 25.0,
          "isAvailable": false,
          "imageUrl":
              "https://media.istockphoto.com/id/1309352410/photo/cheeseburger-with-tomato-and-lettuce-on-wooden-board.webp?s=1024x1024&w=is&k=20&c=XXp34bPwWkHPUXbZQRJpR1w2YUSpYZUB_yNdeDlVXlQ=",
          "averageRating": 3.8,
        },
        {
          "itemId": 5,
          "itemName": "Pizza",
          "itemDescription": "Cheesy pizza topped with flavorful sauces and fresh veggies.",
          "price": 25.0,
          "isAvailable": true,
          "imageUrl": null,
          "averageRating": 5,
        },
        {
          "itemId": 6,
          "itemName": "Sandwich",
          "itemDescription": "Grilled sandwich layered with fresh veggies and spreads.",
          "price": 25.0,
          "isAvailable": false,
          "imageUrl": null,
          "averageRating": 2.1,
        },
        {
          "itemId": 7,
          "itemName": "Fries",
          "itemDescription": "Crispy golden fries lightly salted and perfectly fried.",
          "price": 25.0,
          "isAvailable": true,
          "imageUrl": null,
          "averageRating": 4.8,
        },
      ],
    },
    {
      "categoryId": 2,
      "categoryName": "Beverages",
      "categoryDescription": "Warm and refreshing beverages to energize your day.",
      "imageUrl":
          "https://media.istockphoto.com/id/1296650267/photo/indian-chai-in-glass-cups-with-metal-kettle-and-other-masalas-to-make-the-tea.webp?s=1024x1024&w=is&k=20&c=RpF4WplAx5SOpC3naHFe8vAv_83_4uAtpMFvEI89rYw=",
      "items": [
        {
          "itemId": 1,
          "itemName": "Tea",
          "itemDescription": "Hot brewed tea with rich aroma and soothing taste.",
          "price": 10.0,
          "isAvailable": true,
          "imageUrl": "/uploads/items/6eed960d-f913-4b3c-8f75-d720d3b188a3.jpg",
          "averageRating": 5,
        },
      ],
    },
  ],
};
