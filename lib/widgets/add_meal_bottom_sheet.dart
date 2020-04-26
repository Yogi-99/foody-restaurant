import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_restaurant/models/meal.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/screens/meal_screen.dart';
import 'package:food_restaurant/services/restaurant.dart';
import 'package:food_restaurant/widgets/custom_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddMealBottomSheet extends StatefulWidget {
  @override
  _AddMealBottomSheetState createState() => _AddMealBottomSheetState();
}

class _AddMealBottomSheetState extends State<AddMealBottomSheet> {
  String _name, _decsription, _price, _cookingTime;
  bool _isVeg;
  File _image;
  bool _isLoading = false;
  FoodType _foodType = FoodType.Veg;
  RestaurantService _restaurantService = RestaurantService();
  User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;
  }

  showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.redAccent,
      fontSize: 16.0,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.7,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: _image == null
                            ? Icon(
                                Icons.fastfood,
                                size: 60.0,
                              )
                            : null,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.2),
                            borderRadius: BorderRadius.circular(15.0),
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image), fit: BoxFit.cover)
                                : null),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    CustomInputField(
                      hintText: 'For eg, Mac N\' Cheese burger',
                      labelText: 'Food Name',
                      onTextChange: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      jumpToNext: true,
                    ),
                  ],
                ),
                CustomInputField(
                  hintText: 'For eg, 250 Rs.',
                  labelText: 'Food Price',
                  onTextChange: (value) {
                    setState(() {
                      _price = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  jumpToNext: true,
                ),
                CustomInputField(
                  hintText: 'For eg, 45 mins',
                  labelText: 'Cook time (in minutes)',
                  onTextChange: (value) {
                    setState(() {
                      _cookingTime = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  jumpToNext: true,
                ),
                CustomInputField(
                  hintText: 'For eg, Some Food descriptio here..',
                  labelText: 'Food Description',
                  numberOfLines: 3,
                  onTextChange: (value) {
                    setState(() {
                      _decsription = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  jumpToNext: true,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                          title: Text(
                            'Veg',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Radio(
                            value: FoodType.Veg,
                            groupValue: _foodType,
                            onChanged: ((FoodType foodType) {
                              setState(() {
                                _foodType = foodType;
                              });
                            }),
                          )),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Non Veg',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Radio(
                            value: FoodType.NonVeg,
                            groupValue: _foodType,
                            onChanged: ((FoodType foodType) {
                              setState(() {
                                _foodType = foodType;
                              });
                            })),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final downloadUrl = await _restaurantService
                        .uploadMealImage(_image, _currentUser, _name);
                    final url = downloadUrl.toString();
                    Meal meal = Meal(
                      cookTime: _cookingTime,
                      description: _decsription,
                      foodType: _foodType == FoodType.Veg ? 'Veg' : 'Non Veg',
                      name: _name,
                      price: _price,
                      image: url,
                    );
                    int test =
                        await _restaurantService.isMealPresent(_currentUser);
                    if (test == 0) {
                      _restaurantService.addFirstMeal(_currentUser, meal);
                    } else {
                      _restaurantService.addMeal(_currentUser, meal);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MealScreen()));
                    showMessage('Meal created successfully');
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Colors.redAccent,
                          Colors.red,
                        ])),
                    child: Center(
                      child: Text(
                        "Create Meal",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            child: Center(
              child: _isLoading ? CircularProgressIndicator() : null,
            ),
          ),
        )
      ],
    );
  }
}
