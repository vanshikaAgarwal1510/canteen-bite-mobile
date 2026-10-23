import 'Menu.dart';


class PaymentMethod {
  final int id ;
  final String name;
  final String description;
  final bool deletable;
  final String? imageUrl;
   bool enabled;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.deletable,
    required this.enabled,
    this.imageUrl,
  });


  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      deletable: json['deletable'],
      enabled: json['isEnabled'],
      imageUrl: json['imageUrl'],
    );
  }
}



