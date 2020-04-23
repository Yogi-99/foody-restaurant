import 'package:flutter/material.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/widgets/drawer.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  static String id = 'bottom_navigation_screen';
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawer(),
    );
  }
}
