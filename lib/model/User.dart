import 'Menu.dart';


class User {
  final String name;
  final String mobileNumber;
  final String? imageUrl;
  final bool isUniversityStudent;

  User({
    required this.name,
    required this.mobileNumber,
     this.imageUrl,
    required this.isUniversityStudent,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['fullName'],
      mobileNumber: json['mobileNumber'],
      imageUrl: json['imageUrl'],
      isUniversityStudent: json['isUniversityStudent'],
    );
  }


}