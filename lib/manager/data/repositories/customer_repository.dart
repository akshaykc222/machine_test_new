import 'package:crm_machine_test/manager/data/models/customer_model.dart';

abstract class CustomerRepository {
  Future<void> createCustomer(CustomerModel model);
  Future<void> deleteCustomer(CustomerModel model);
  Future<void> updateCustomer(CustomerModel model);
  Future<void> requestEditAccess(CustomerModel model);
  Future<void> updateEditAccess(String docId);
}
