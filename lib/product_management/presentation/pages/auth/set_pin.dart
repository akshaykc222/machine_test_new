import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();

  //text controllers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    authBloc = AuthBloc.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            spacer50,
            const Text(
              "Set Pin code",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            spacer10,
            const Text(
              "Set pin code to access app later",
              style: TextStyle(
                fontSize: 25,
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
                authBloc.add(SetPinEvent(pin, context));
              },
            ),
            spacer10,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state is AuthLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is AuthError
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.errorRed,
                            ),
                            child: Text(
                              state.error,
                              style: const TextStyle(color: AppColors.white),
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
