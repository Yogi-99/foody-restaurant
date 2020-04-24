import 'package:flutter/foundation.dart';
import 'package:food_restaurant/models/restaurant.dart';
import 'package:food_restaurant/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _currentUser;
  Restaurant _restaurant;

  User get currentUser => _currentUser;
  Restaurant get restaurant => _restaurant;

  setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  setCurrentRestaurant(Restaurant restaurant) {
    _restaurant = restaurant;
    notifyListeners();
  }
}
