import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/manager/data/models/request/sign_in_request.dart';
import 'package:crm_machine_test/manager/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUseCase extends UseCase<UserCredential, SignInRequestModel> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<UserCredential> call(SignInRequestModel params) {
    return repository.signUp(params);
  }
}
