import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/manager/data/data_sources/auth_data_source.dart';
import 'package:crm_machine_test/manager/data/data_sources/customer_data_source.dart';
import 'package:crm_machine_test/manager/data/repositories/auth_repository.dart';
import 'package:crm_machine_test/manager/data/repositories/customer_repository.dart';
import 'package:crm_machine_test/manager/data/repositories/notification_repository.dart';
import 'package:crm_machine_test/manager/domain/repositories/auth_repository_impl.dart';
import 'package:crm_machine_test/manager/domain/repositories/customer_repository_impl.dart';
import 'package:crm_machine_test/manager/domain/repositories/notification_repository_impl.dart';
import 'package:crm_machine_test/manager/domain/use_cases/add_customer_use_case.dart';
import 'package:crm_machine_test/manager/domain/use_cases/login_use_case.dart';
import 'package:crm_machine_test/manager/domain/use_cases/register_use_case.dart';
import 'package:crm_machine_test/manager/domain/use_cases/update_customer_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());
  //data source
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(FirebaseAuth.instance, sl()));
  sl.registerLazySingleton<CustomerDataSource>(
      () => CustomerDataSourceImpl(sl()));

  //repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl());

  //use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<UpdateCustomerUseCase>(
      () => UpdateCustomerUseCase(sl()));
  sl.registerLazySingleton<AddCustomerUserCase>(
      () => AddCustomerUserCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
}
