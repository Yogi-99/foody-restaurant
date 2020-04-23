import 'package:flutter/material.dart';
import 'package:food_restaurant/widgets/drawer.dart';

class MealScreen extends StatelessWidget {
  static String id = 'meal_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals Screen'),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
