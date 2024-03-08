import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserUseCase extends UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<User?> call(NoParams params) {
    return repository.getUser();
  }
}
