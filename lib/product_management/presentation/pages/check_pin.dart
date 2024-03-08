import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class CheckPinScreen extends StatefulWidget {
  const CheckPinScreen({super.key});

  @override
  State<CheckPinScreen> createState() => _CheckPinScreenState();
}

class _CheckPinScreenState extends State<CheckPinScreen> {
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = AuthBloc.get(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Enter your pin to continue..",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            spacer25,
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 80,
              style: const TextStyle(fontSize: 20),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                authBloc.add(CheckPinEvent(pin: pin, context: context));
              },
            ),
            spacer25,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state is AuthLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is AuthError
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.errorRed,
                            ),
                            child: Center(
                              child: Text(
                                state.error,
                                style: const TextStyle(color: AppColors.white),
                              ),
                            ),
                          )
                        : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
