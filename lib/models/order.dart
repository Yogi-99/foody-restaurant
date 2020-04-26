import 'package:food_restaurant/models/meal.dart';
import 'package:food_restaurant/models/restaurant.dart';
import 'package:food_restaurant/models/user.dart';

class Order {
  final String id;
  final Meal meal;
  final Restaurant restaurant;
  final String status;
  final User user;
  final String address;
  final String city;
  final String pinCode;
  final String quantiy;
  final String totalAmount;
  final String createdAt;

  Order({
    this.id,
    this.meal,
    this.restaurant,
    this.status,
    this.user,
    this.address,
    this.city,
    this.pinCode,
    this.quantiy,
    this.totalAmount,
    this.createdAt,
  });

  factory Order.fromJson(Map data) {
    return Order(
      id: data['id'],
      meal: Meal.fromJson(data['meal']),
      restaurant: Restaurant.fromJson(data['restaurant']),
      status: data['status'],
      user: User.fromJson(data['user']),
      address: data['address'],
      city: data['city'],
      pinCode: data['pin_code'],
      quantiy: data['quantiy'],
      totalAmount: data['total_amount'],
      createdAt: data['created_at'],
    );
  }
}
