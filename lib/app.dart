import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/manager/product/product_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_router.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrmApp extends StatelessWidget {
  const CrmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProductBloc()),
      ],
      child: MaterialApp.router(
        title: 'Machine Test',
        theme: AppTheme.primaryTheme,
        routerConfig: AppRouter.routerConfig,
      ),
    );
  }
}
