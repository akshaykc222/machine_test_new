import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';

class SetPinUseCase extends UseCase<void, String> {
  final AuthRepository repository;

  SetPinUseCase(this.repository);

  @override
  Future<void> call(String params) {
    return repository.setPin(params);
  }
}
