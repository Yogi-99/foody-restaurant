import 'package:food_restaurant/models/restaurant.dart';

class User {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String image;
  final String type;

  User({
    this.id,
    this.username,
    this.type,
    this.image,
    this.fullName,
    this.email,
    this.password,
    this.phone,
  });

  factory User.fromJson(Map data) {
    return User(
      email: data['email'],
      fullName: data['full_name'],
      id: data['id'],
      image: data['image'],
      password: data['password'],
      username: data['username'],
      type: data['email'],
      phone: data['phone'],
    );
  }
}
