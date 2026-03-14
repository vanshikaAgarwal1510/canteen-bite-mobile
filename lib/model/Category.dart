import 'Menu.dart';


class Category {
  final int categoryId;
  final String categoryName;
  final String categoryDescription;
  final String imageUrl;
  final List<MenuItem>? items;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
    required this.imageUrl,
     this.items,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
      imageUrl: json['imageUrl'],
      items: (json['items']!=null)?(json['items'] as List)
          .map((e) => MenuItem.fromJson(e))
          .toList(): []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'items': items!.map((e) => e.toJson()).toList(),
    };
  }
}