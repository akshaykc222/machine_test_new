import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/manager/data/data_sources/collections.dart';
import 'package:crm_machine_test/manager/data/models/request/sign_in_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<UserCredential> signUp(SignInRequestModel request);
  Future<UserCredential> signIn(SignInRequestModel request);
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
      await firebaseService.addData(
          collection: Collections.user,
          data: {'user': userCredential.user?.uid, 'role': request.role.name});
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
      throw Exception(e);
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
}
