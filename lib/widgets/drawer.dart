import 'package:flutter/material.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/screens/login_screen.dart';
import 'package:food_restaurant/screens/meal_screen.dart';
import 'package:food_restaurant/screens/order_screen.dart';
import 'package:food_restaurant/screens/restaurant_screen.dart';
import 'package:food_restaurant/services/auth.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  AuthService _authService = AuthService();
  User currentUser;
  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('${currentUser.email}',
                style: TextStyle(fontWeight: FontWeight.w400)),
            accountName: Text(
              'Hey, ${currentUser.username}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // decoration: BoxDecoration(color: Colors.green),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(currentUser.image),
            ),
            arrowColor: Colors.greenAccent,
          ),
          ListTile(
            title: Text(
              'Restaurant',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.restaurant,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushNamed(context, RestaurantScreen.id);
            },
          ),
          ListTile(
            title: Text(
              'Orders',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.fastfood,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.id);
            },
          ),
          ListTile(
            title: Text(
              'Meals',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.create,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushNamed(context, MealScreen.id);
            },
          ),
          Expanded(child: Container()),
          Divider(
            color: Colors.redAccent,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              'Sign out',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.black.withOpacity(.8)),
            ),
            onTap: () async {
              await _authService.singOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.id, (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
