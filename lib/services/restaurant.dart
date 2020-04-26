import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_restaurant/global/databasr_fields.dart';
import 'package:food_restaurant/models/meal.dart';
import 'package:food_restaurant/models/restaurant.dart';
import 'package:food_restaurant/models/user.dart';

class RestaurantService {
  final Firestore _db = Firestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<Restaurant> getUsersRestaurant(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _db.collection(RESTAURANT_COLLECTION).document(userId).get();

    if (documentSnapshot.data != null) {
      return Restaurant.fromJson(documentSnapshot.data);
    }
  }

  Future<List<Meal>> getMeals(User user) async {
    List<Meal> meals = [];
    try {
      DocumentSnapshot documentSnapshot =
          await _db.collection(MEALS_COLLECTION).document(user.id).get();

      List dummyData = documentSnapshot.data['meals'];
      dummyData.forEach((f) {
        meals.add(Meal.fromJson(f));
      });
    } catch (e) {
      print('getMeals(): error: ${e.toString()}');
    }
    return meals;
  }

  deleteMeal(User user, Meal meal) {
    _db.collection(MEALS_COLLECTION).document(user.id).updateData({
      'meals': FieldValue.arrayRemove([meal.toJson()])
    });
    print('done');
  }

  Future<int> isMealPresent(User user) async {
    List<Meal> meals = [];
    try {
      DocumentSnapshot documentSnapshot =
          await _db.collection(MEALS_COLLECTION).document(user.id).get();

      List dummyData = documentSnapshot.data['meals'];
      dummyData.forEach((f) {
        meals.add(Meal.fromJson(f));
      });
      print('here');
      return meals.length;
    } catch (e) {
      print('getMeals(): error: ${e.toString()}');
    }
  }

  addMeal(User user, Meal meal) {
    print('meal name: ${meal.name}');
    _db.collection(MEALS_COLLECTION).document(user.id).updateData(
      {
        'meals': FieldValue.arrayUnion([meal.toJson()])
      },
    );
    print('done');
  }

  addFirstMeal(User user, Meal meal) {
    print('meal name: ${meal.name}');
    _db.collection(MEALS_COLLECTION).document(user.id).setData(
      {
        'meals': FieldValue.arrayUnion([meal.toJson()])
      },
    );
    print('done');
  }

  uploadMealImage(File image, User user, String mealName) async {
    try {
      StorageReference storageReference =
          _firebaseStorage.ref().child('meals/$mealName-${user.id}');
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
