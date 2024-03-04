import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/domain/use_cases/add_customer_use_case.dart';
import 'package:crm_machine_test/manager/domain/use_cases/update_customer_use_case.dart';
import 'package:crm_machine_test/manager/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<CustomerEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddCustomerEvent>((event, emit) async {
      print("adding");
      emit(CustomerLoading());
      try {
        await addCustomerUseCase.call(event.model);
        emit(CustomerLoaded());
      } catch (e) {
        print(e);
        emit(CustomerError(e.toString()));
      }
    });
    on<UpdateCustomer>((event, emit) async {
      emit(CustomerLoading());
      try {
        await updateCustomerUseCase.call(event.model);
        emit(CustomerLoaded());
      } catch (e) {
        print(e);
        emit(CustomerError(e.toString()));
      }
    });
  }
  //use cases
  final addCustomerUseCase = sl<AddCustomerUserCase>();
  final updateCustomerUseCase = sl<UpdateCustomerUseCase>();

  static CustomerBloc get(context) => BlocProvider.of(context);
}
