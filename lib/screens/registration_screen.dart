import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/screens/bottom_navigation_screen.dart';
import 'package:food_restaurant/screens/login_screen.dart';
import 'package:food_restaurant/services/auth.dart';

import 'package:food_restaurant/widgets/input_field.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _username, _email, _fullName, _password, _phone, _confirmPassword;

  File _image;
  AuthService _authService = AuthService();

  bool _isLoading = false;

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.9),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            InputField(
                              showDivider: true,
                              hint: 'Username',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                            ),
                            InputField(
                              showDivider: true,
                              hint: 'Email',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            InputField(
                              showDivider: true,
                              hint: 'Full Name',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _fullName = value;
                                });
                              },
                            ),
                            InputField(
                              showDivider: true,
                              hint: 'Password',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                            InputField(
                              showDivider: true,
                              hint: 'Confirm Password',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _confirmPassword = value;
                                });
                              },
                            ),
                            InputField(
                              showDivider: false,
                              hint: 'Contact Number',
                              inputType: TextInputType.text,
                              isObscure: false,
                              onTextChange: (value) {
                                setState(() {
                                  _phone = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          print('clicked');
                          _getImage();
                        },
                        child: CircleAvatar(
                          radius: 35.0,
                          child: _image == null
                              ? Icon(
                                  Icons.account_circle,
                                  size: 60.0,
                                )
                              : Icon(
                                  Icons.check,
                                  size: 50.0,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40.0,
                        left: 0.0,
                        bottom: 0.0,
                        right: 0.0,
                        child: Center(
                          child:
                              _isLoading ? CircularProgressIndicator() : null,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          User user = User(
                            email: _email,
                            fullName: _fullName,
                            password: _password,
                            phone: _phone,
                            username: _username,
                            type: 'Restaurant Owner',
                          );
                          try {
                            FirebaseUser firebaseUser =
                                await _authService.createUser(user, _image);
                            if (firebaseUser != null) {
                              setState(() {
                                _isLoading = false;
                              });
                              showMessage('User successfully created.');
                            }
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            showMessage('Some error occured');
                            print(
                                'Registration Screen: error: ${e.toString()}');
                          }

                          setState(() {
                            _isLoading = false;
                          });
                          showMessage('User successfully created');

                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              BottomNavigationScreen.id,
                              (Route<dynamic> route) => false);
                        }, //since this is only a UI app
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color(0xffff2d55),
                        elevation: 0,
                        minWidth: 400,
                        height: 50,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
