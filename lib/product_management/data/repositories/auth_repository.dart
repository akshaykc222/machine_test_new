import 'package:crm_machine_test/product_management/data/models/request/sign_in_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signUp(SignInRequestModel request);
  Future<UserCredential> signIn(SignInRequestModel request);
  Future<void> logOut();
  Future<User?> getUser();
  Future<void> setPin(String pin);
  Future<bool> checkPin(String pin);
  Future<void> checkPinCreated();
}
