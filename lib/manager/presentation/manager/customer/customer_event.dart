part of 'customer_bloc.dart';

abstract class CustomerEvent {}

class AddCustomerEvent extends CustomerEvent {
  final CustomerModel model;

  AddCustomerEvent(this.model);
}

class DeleteCustomer extends CustomerEvent {
  final CustomerModel model;

  DeleteCustomer(this.model);
}

class UpdateCustomer extends CustomerEvent {
  final CustomerModel model;

  UpdateCustomer(this.model);
}

class RequestEditAccessEvent extends CustomerEvent {
  final CustomerModel model;

  RequestEditAccessEvent(this.model);
}
