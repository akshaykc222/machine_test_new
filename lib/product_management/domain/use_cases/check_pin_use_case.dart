import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';

class CheckPinUseCase extends UseCase<bool, String> {
  final AuthRepository repository;

  CheckPinUseCase(this.repository);

  @override
  Future<bool> call(String params) {
    return repository.checkPin(params);
  }
}
