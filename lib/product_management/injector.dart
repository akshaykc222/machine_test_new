import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/product_management/data/data_sources/auth_data_source.dart';
import 'package:crm_machine_test/product_management/data/data_sources/product_data_source.dart';
import 'package:crm_machine_test/product_management/data/repositories/auth_repository.dart';
import 'package:crm_machine_test/product_management/data/repositories/product_repository.dart';
import 'package:crm_machine_test/product_management/domain/repositories/auth_repository_impl.dart';
import 'package:crm_machine_test/product_management/domain/repositories/product_repository_impl.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/add_product_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/check_pin_created_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/check_pin_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/edit_product_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/get_product_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/get_user_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/login_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/register_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/set_pin_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //core
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());
  //data source
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(FirebaseAuth.instance, sl()));
  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(sl()));
  //repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  //use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<CheckPinUseCase>(() => CheckPinUseCase(sl()));
  sl.registerLazySingleton<CheckPinCreatedUseCase>(
      () => CheckPinCreatedUseCase(sl()));
  sl.registerLazySingleton<SetPinUseCase>(() => SetPinUseCase(sl()));
  sl.registerLazySingleton<AddProductUseCase>(() => AddProductUseCase(sl()));
  sl.registerLazySingleton<EditProductUseCase>(() => EditProductUseCase(sl()));
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));
  sl.registerLazySingleton<GetProductUseCase>(() => GetProductUseCase(sl()));
}
