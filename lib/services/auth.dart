import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_restaurant/models/user.dart';
import 'package:food_restaurant/screens/login_screen.dart';
import '../global/global.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<FirebaseUser> get currentUser => _firebaseAuth.currentUser();

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      final newUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return newUser.user;
    } catch (e) {
      print('error: $e');
    }
  }

  Future<FirebaseUser> createUser(User user, File image) async {
    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      final downloadUrl = await uploadUserProfileImage(image, newUser.user);
      final url = downloadUrl.toString();
      await createUserDB(newUser.user, user, url);

      return newUser.user;
    } catch (e) {
      print('error: ${e.toString()}');
    }
    return null;
  }

  createUserDB(FirebaseUser firebaseUser, User user, String url) {
    DocumentReference documentReference =
        _db.collection(USERS_COLLECTION).document(firebaseUser.uid);

    return documentReference.setData({
      'id': firebaseUser.uid,
      'username': user.username,
      'full_name': user.fullName,
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
      'image': url,
      'type': user.type,
      // 'restaurant': user.restaurant,
    }, merge: true);
  }

  uploadUserProfileImage(File image, FirebaseUser firebaseUser) async {
    try {
      StorageReference storageReference =
          _firebaseStorage.ref().child('users/${firebaseUser.uid}');
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

  Future<User> getLoggedInUserData(
      FirebaseUser firebaseUser, BuildContext context) async {
    try {
      DocumentSnapshot documentSnapshot = await _db
          .collection(USERS_COLLECTION)
          .document(firebaseUser.uid)
          .get();

      User user = User.fromJson(documentSnapshot.data);
      return user;
    } catch (e) {
      print('getLoggedInUserData(): error: ${e.toString()}');
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  singOut() async {
    await _firebaseAuth.signOut();
  }
}
