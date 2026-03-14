import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:canteen_bite_mobile/model/User.dart';

class InitResponse {
  int status;
  String message;
  List<Category> categories;
  User? userData;

  InitResponse({
    required this.status,
    required this.message,
    required this.categories,
    this.userData,
  });

  factory InitResponse.fromJson(Map<String, dynamic> json) {

    List<Category> categories = [];
    User? userData;

    if (json['data'] != null) {

      if (json['data']['menu'] != null) {
        categories = (json['data']['menu'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }

      if (json['data']['user'] != null) {
        userData = User.fromJson(json['data']['user']);
      }

    }

    return InitResponse(
      status: json['status'],
      message: json['message'],
      categories: categories,
      userData: userData,
    );
  }
}