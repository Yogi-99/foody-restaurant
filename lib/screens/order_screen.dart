import 'package:flutter/material.dart';
import 'package:food_restaurant/widgets/drawer.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'order_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Screen'),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
