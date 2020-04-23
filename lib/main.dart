import 'package:flutter/material.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/screens/bottom_navigation_screen.dart';
import 'package:food_restaurant/screens/login_screen.dart';
import 'package:food_restaurant/screens/meal_screen.dart';
import 'package:food_restaurant/screens/order_screen.dart';
import 'package:food_restaurant/screens/registration_screen.dart';
import 'package:food_restaurant/screens/restaurant_screen.dart';
import 'package:food_restaurant/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        theme: ThemeData.light().copyWith(primaryColor: Color(0xffff2d55)),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          BottomNavigationScreen.id: (context) => BottomNavigationScreen(),
          RestaurantScreen.id: (context) => RestaurantScreen(),
          MealScreen.id: (context) => MealScreen(),
          OrderScreen.id: (context) => OrderScreen(),
        },
      ),
    );
  }
}
