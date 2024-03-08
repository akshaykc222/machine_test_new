import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = AuthBloc.get(context);
    authBloc.add(GetCurrentUserEvent(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
