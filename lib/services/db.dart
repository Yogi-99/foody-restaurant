import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_restaurant/global/databasr_fields.dart';
import 'package:food_restaurant/models/restaurant.dart';
import 'package:food_restaurant/models/user.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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

  addRestaurantDetails(User user, Restaurant restaurant, File image) async {
    DocumentReference documentReference =
        _db.collection(RESTAURANT_COLLECTION).document(user.id);

    final downloadUrl = await uploadRestaurantImage(image, user);
    final url = downloadUrl.toString();

    documentReference.setData({
      'id': user.id,
      'name': restaurant.name,
      'address': restaurant.address,
      'city': restaurant.city,
      'phone': restaurant.phone,
      'image': url,
    }, merge: true);
    showMessage('Data successfully updated.');
  }

  uploadRestaurantImage(File image, User user) async {
    try {
      StorageReference storageReference =
          _firebaseStorage.ref().child('restaurants/${user.id}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      var downloadUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      final url = downloadUrl.toString();
      print('download url: $url');
      return downloadUrl;
    } catch (e) {
      print('firebase storage error: ${e.toString()}');
    }
  }
}
