import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/manager/data/data_sources/collections.dart';
import 'package:crm_machine_test/manager/data/models/customer_model.dart';

abstract class CustomerDataSource {
  Future<void> createCustomer(CustomerModel model);
  Future<void> deleteCustomer(CustomerModel model);
  Future<void> updateCustomer(CustomerModel model);
  Future<void> requestEditAccess(CustomerModel model);
  Future<void> updateEditAccess(String docId);
}

class CustomerDataSourceImpl extends CustomerDataSource {
  final FirebaseService firebaseService;

  CustomerDataSourceImpl(this.firebaseService);

  @override
  Future<void> createCustomer(CustomerModel model) async {
    await firebaseService.addData(
        collection: Collections.customer, data: model.toJson());
  }

  @override
  Future<void> deleteCustomer(CustomerModel model) async {
    await firebaseService.deleteData(model.id.toString());
  }

  @override
  Future<void> updateCustomer(CustomerModel model) async {
    await firebaseService.updateData(model.id.toString(), model.toJson());
  }

  @override
  Future<void> requestEditAccess(CustomerModel model) async {
    await firebaseService.addData(
        collection: Collections.editAccess,
        data: {'customer': model.id, 'granted': false});
  }

  @override
  Future<void> updateEditAccess(String docId) async {
    await firebaseService.updateData(docId, {'granted': true});
  }
}
