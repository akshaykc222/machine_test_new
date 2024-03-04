import 'package:crm_machine_test/manager/data/data_sources/customer_data_source.dart';
import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/data/repositories/customer_repository.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final CustomerDataSource dataSource;

  CustomerRepositoryImpl(this.dataSource);

  @override
  Future<void> createCustomer(CustomerModel model) {
    return dataSource.createCustomer(model);
  }

  @override
  Future<void> deleteCustomer(CustomerModel model) {
    return dataSource.deleteCustomer(model);
  }

  @override
  Future<void> requestEditAccess(CustomerModel model) {
    return dataSource.requestEditAccess(model);
  }

  @override
  Future<void> updateCustomer(CustomerModel model) {
    return dataSource.updateCustomer(model);
  }

  @override
  Future<void> updateEditAccess(String docId) {
    return dataSource.updateEditAccess(docId);
  }
}
