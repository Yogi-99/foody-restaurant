import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_restaurant/models/restaurant.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/providers/user.dart';
import 'package:food_restaurant/services/db.dart';
import 'package:food_restaurant/widgets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatefulWidget {
  static String id = 'restaurant_screen';

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  File _image;
  String _name = 'Name',
      _address = 'Address',
      _phone = 'Contact Number',
      _city = 'City',
      _imageUrl = '';
  DatabaseService _databaseService = DatabaseService();
  User _currentUser;
  bool _isLoading = false;
  bool _useImagePicker = false;

  @override
  void initState() {
    super.initState();
    _showRestaurantInfo();
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

  _showRestaurantInfo() {
    Restaurant restaurant =
        Provider.of<UserProvider>(context, listen: false).restaurant;
    if (restaurant != null) {
      _address = restaurant.address;
      _city = restaurant.city;
      _name = restaurant.name;
      _phone = restaurant.phone;
      _imageUrl = restaurant.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Details'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                size: 30.0,
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                print('city: $_city');
                Restaurant restaurant = Restaurant(
                  address: _address,
                  city: _city,
                  name: _name,
                  phone: _phone,
                );
                await _databaseService.addRestaurantDetails(
                    _currentUser, restaurant, _image);

                setState(() {
                  _isLoading = false;
                });
              })
        ],
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                        image: Provider.of<UserProvider>(context, listen: false)
                                        .restaurant !=
                                    null &&
                                !_useImagePicker
                            ? DecorationImage(
                                image: NetworkImage(_imageUrl),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: FileImage(_image), fit: BoxFit.cover)),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            _useImagePicker = true;
                            _getImage();
                          },
                          child: _image == null || _imageUrl == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 100.0,
                                  color: Colors.grey,
                                )
                              : null),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: _name,
                              labelStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                              hintText: 'Restaurants Name ',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.5))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _phone = value;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: _phone,
                              labelStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                              hintText: 'Contact Number',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.5))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              _address = value;
                            });
                          },
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: _address,
                              labelStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.5))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              _city = value;
                            });
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: _city,
                              labelStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                              hintText: 'City',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.5))),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
        ),
      ),
    );
  }
}
