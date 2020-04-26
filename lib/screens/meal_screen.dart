import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_restaurant/models/meal.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/services/restaurant.dart';

import 'package:food_restaurant/widgets/add_meal_bottom_sheet.dart';
import 'package:food_restaurant/widgets/drawer.dart';
import 'package:food_restaurant/widgets/meal_list_tile.dart';
import 'package:provider/provider.dart';

enum FoodType { Veg, NonVeg }

class MealScreen extends StatelessWidget {
  static String id = 'meal_screen';
  RestaurantService _restaurantService = RestaurantService();

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = [];
    _restaurantService.getMeals(
        Provider.of<UserProvider>(context, listen: false).currentUser);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals Screen'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                _restaurantService
                    .isMealPresent(
                        Provider.of<UserProvider>(context, listen: false)
                            .currentUser)
                    .then((onValue) {
                  print('ismeal()');
                  print(onValue);
                });
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    builder: (context) => AddMealBottomSheet());
              })
        ],
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder(
        future: _restaurantService.getMeals(
            Provider.of<UserProvider>(context, listen: false).currentUser),
        builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
          if (snapshot.hasData) {
            meals = snapshot.data;
            print(meals);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (BuildContext context, int index) {
                  Meal meal = meals[index];
                  return MealListTile(meal: meal);
                },
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
