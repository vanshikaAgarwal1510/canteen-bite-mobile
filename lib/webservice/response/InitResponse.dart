import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:canteen_bite_mobile/model/Menu.dart';
import 'package:canteen_bite_mobile/model/User.dart';

class InitResponse {
  int status;
  String message;
  List<Category> categories;
  List<MenuItem> recommends;
  User? userData;

  InitResponse({
    required this.status,
    required this.message,
    required this.categories,
    required this.recommends,
    this.userData,
  });

  factory InitResponse.fromJson(Map<String, dynamic> json) {

    List<Category> categories = [];
    User? userData;
    List<MenuItem> recommends =[];

    if (json['data'] != null) {

      if (json['data']['menu'] != null) {
        categories = (json['data']['menu'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }

      if (json['data']['user'] != null) {
        userData = User.fromJson(json['data']['user']);
      }
      if (json['data']['recommendMenu'] != null) {
        recommends = (json['data']['recommendMenu'] as List)
            .map((e) => MenuItem.fromJson(e))
            .toList();
      }

    }

    return InitResponse(
      status: json['status'],
      message: json['message'],
      categories: categories,
      userData: userData,
      recommends: recommends
    );
  }
}