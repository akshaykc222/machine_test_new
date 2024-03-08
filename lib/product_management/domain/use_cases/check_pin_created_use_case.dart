import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';

class CheckPinCreatedUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  CheckPinCreatedUseCase(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.checkPinCreated();
  }
}
