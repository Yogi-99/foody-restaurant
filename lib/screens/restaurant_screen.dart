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
  String _name, _address, _phone, _city;
  DatabaseService _databaseService = DatabaseService();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Details'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                size: 30.0,
              ),
              onPressed: () {
                Restaurant restaurant = Restaurant(
                  address: _address,
                  city: _city,
                  name: _name,
                  phone: _phone,
                );
                _databaseService.addRestaurantDetails(
                    _currentUser, restaurant, _image);
                showMessage('Data successfully updated.');
              })
        ],
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image), fit: BoxFit.cover)
                      : null,
                ),
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: _image == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 100.0,
                              color: Colors.grey,
                            )
                          : null),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Restaurant Name',
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.red),
                          hintText: 'For eg, The Nutty Bunch..',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5))),
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
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contact Number',
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.red),
                          hintText: 'For eg, (239)-173-8951',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5))),
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
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.red),
                          hintText: 'For eg, 2961 Wheeler Ridge Dr',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5))),
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
                          labelText: 'City',
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.red),
                          hintText: 'For eg, Amsterdam..',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
