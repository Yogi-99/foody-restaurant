import 'package:flutter/material.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/screens/bottom_navigation_screen.dart';
import 'package:food_restaurant/screens/login_screen.dart';
import 'package:food_restaurant/screens/restaurant_screen.dart';
import 'package:food_restaurant/services/auth.dart';
import 'package:food_restaurant/services/restaurant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService _authService = AuthService();
  RestaurantService _restaurantService = RestaurantService();

  _pushToLogin(int seconds) {
    Future.delayed(Duration(seconds: seconds), () {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
  }

  _pushToHome(int seconds) {
    Future.delayed(Duration(seconds: seconds), () {
      Navigator.pushReplacementNamed(context, RestaurantScreen.id);
    });
  }

  _checkAuthState() async {
    _authService.currentUser.then((currentFirebaseUser) async {
      if (currentFirebaseUser != null) {
        Provider.of<UserProvider>(context, listen: false).setCurrentUser(
            await _authService.getLoggedInUserData(currentFirebaseUser));

        Provider.of<UserProvider>(context, listen: false).setCurrentRestaurant(
            await _restaurantService
                .getUsersRestaurant(currentFirebaseUser.uid));

        _pushToHome(2);
      } else {
        _pushToLogin(2);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child:
                  LottieBuilder.asset('assets/splash_screen/food_loading.json'))
        ],
      ),
    );
  }
}
