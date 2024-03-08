import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_machine_test/core/custom_exceptions.dart';
import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/product_management/data/data_sources/collections.dart';
import 'package:crm_machine_test/product_management/data/models/request/sign_in_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthDataSource {
  Future<UserCredential> signUp(SignInRequestModel request);
  Future<UserCredential> signIn(SignInRequestModel request);
  Future<void> setPin(String pin);
  Future<bool> checkPin(String pin);
  Future<void> checkPinCreated();
  Future<void> logOut();
  Future<User?> getUser();
}

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth auth;
  final FirebaseService firebaseService;

  AuthDataSourceImpl(this.auth, this.firebaseService);

  @override
  Future<UserCredential> signUp(SignInRequestModel request) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      await firebaseService.addData(collection: Collections.user, data: {
        'user': userCredential.user?.uid,
      });
      return userCredential;
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw Exception(e.message);
      } else {
        throw Exception(e);
      }
    }
  }

  @override
  Future<UserCredential> signIn(SignInRequestModel request) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return userCredential;
    } catch (e) {
      throw CustomException("The entered email/password is incorrect.");
    }
  }

  @override
  Future<User?> getUser() async {
    return auth.currentUser;
  }

  @override
  Future<void> logOut() async {
    await auth.signOut();
  }

  @override
  Future<void> setPin(String pin) async {
    var user = auth.currentUser?.uid;
    if (auth.currentUser == null) {
      throw UnAuthorizedException();
    }
    await firebaseService
        .addData(collection: Collections.pin, data: {'user': user, 'pin': pin});
  }

  @override
  Future<bool> checkPin(String pin) async {
    var user = auth.currentUser?.uid;
    if (auth.currentUser == null) {
      throw UnAuthorizedException();
    }
    var pinCollections =
        await firebaseService.getData(collection: Collections.pin);
    QuerySnapshot querySnapshot =
        await pinCollections.where('user', isEqualTo: user).get();
    if (querySnapshot.docs.isNotEmpty) {
      String storedPin = querySnapshot.docs.first.get('pin');
      if (pin == storedPin) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> checkPinCreated() async {
    try {
      var user = auth.currentUser?.uid;
      var pinCollections =
          await firebaseService.getData(collection: Collections.pin);
      QuerySnapshot querySnapshot =
          await pinCollections.where('user', isEqualTo: user).get();
      if (querySnapshot.docs.isEmpty) {
        debugPrint("no pin set");
        throw NoPinException("please set pin");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
