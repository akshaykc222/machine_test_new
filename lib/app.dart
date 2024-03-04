import 'package:crm_machine_test/manager/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/manager/presentation/manager/customer/customer_bloc.dart';
import 'package:crm_machine_test/manager/presentation/manager/home/home_bloc.dart';
import 'package:crm_machine_test/manager/presentation/router/app_router.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
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
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CustomerBloc()),
      ],
      child: MaterialApp.router(
        title: 'Machine Test',
        theme: AppTheme.primaryTheme,
        routerConfig: AppRouter.routerConfig,
      ),
    );
  }
}
