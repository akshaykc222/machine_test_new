import 'package:crm_machine_test/product_management/data/data_sources/auth_data_source.dart';
import 'package:crm_machine_test/product_management/data/models/request/sign_in_request.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User?> getUser() {
    return dataSource.getUser();
  }

  @override
  Future<void> logOut() {
    return dataSource.logOut();
  }

  @override
  Future<UserCredential> signIn(SignInRequestModel request) {
    return dataSource.signIn(request);
  }

  @override
  Future<UserCredential> signUp(SignInRequestModel request) {
    return dataSource.signUp(request);
  }

  @override
  Future<bool> checkPin(String pin) {
    return dataSource.checkPin(pin);
  }

  @override
  Future<void> checkPinCreated() {
    return dataSource.checkPinCreated();
  }

  @override
  Future<void> setPin(String pin) {
    return dataSource.setPin(pin);
  }
}
