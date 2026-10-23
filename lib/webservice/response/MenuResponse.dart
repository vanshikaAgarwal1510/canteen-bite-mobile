import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:canteen_bite_mobile/model/Menu.dart';
import 'package:canteen_bite_mobile/model/User.dart';

class MenuResponse {
  int status;
  String message;
  List<Category> categories;


  MenuResponse({
    required this.status,
    required this.message,
    required this.categories,

  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) {

    List<Category> categories = [];


    if (json['data'] != null) {

      if (json['data'] != null) {
        categories = (json['data'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    }

    return MenuResponse(
        status: json['status'],
        message: json['message'],
        categories: categories,
    );
  }
}