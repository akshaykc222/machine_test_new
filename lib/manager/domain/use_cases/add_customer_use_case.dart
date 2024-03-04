import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/data/repositories/customer_repository.dart';

class AddCustomerUserCase extends UseCase<void, CustomerModel> {
  final CustomerRepository repository;

  AddCustomerUserCase(this.repository);

  @override
  Future<void> call(CustomerModel params) {
    return repository.createCustomer(params);
  }
}
