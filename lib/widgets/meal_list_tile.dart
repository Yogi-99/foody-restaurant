import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_restaurant/models/meal.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/screens/meal_screen.dart';
import 'package:food_restaurant/services/restaurant.dart';
import 'package:provider/provider.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  MealListTile({
    @required this.meal,
  });
  RestaurantService _restaurantService = RestaurantService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 100.0,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: Colors.grey.withOpacity(.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              width: 100.0,
              height: 110.0,
              fit: BoxFit.cover,
              image: NetworkImage(
                meal.image,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          meal.name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        child: SvgPicture.asset(
                            'assets/svgs/indian-vegetarian-mark.svg'),
                      ),
                    ],
                  ),
                  Text(
                    meal.description,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.7), fontSize: 16.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 26.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(meal.cookTime),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text('mins'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.attach_money,
                              size: 26.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(meal.price),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(6.0),
            child: GestureDetector(
                child: Icon(
                  Icons.delete,
                  size: 30.0,
                  color: Colors.red,
                ),
                onTap: () {
                  _restaurantService.deleteMeal(
                      Provider.of<UserProvider>(context, listen: false)
                          .currentUser,
                      meal);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MealScreen()),
                      (Route<dynamic> route) => false);
                  print('clicked');
                }),
          ),
        ],
      ),
    );
  }
}
