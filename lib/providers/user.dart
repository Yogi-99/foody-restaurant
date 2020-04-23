import 'package:flutter/foundation.dart';
import 'package:food_restaurant/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _currentUser;

  User get currentUser => _currentUser;

  setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
