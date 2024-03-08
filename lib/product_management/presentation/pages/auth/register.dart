import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_constants.dart';
import 'package:crm_machine_test/product_management/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();

  //text controllers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    authBloc = AuthBloc.get(context);
    authBloc.add(RegisterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: const Icon(LineAwesomeIcons.arrow_left)),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            spacer50,
            const Text(
              "Register",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            spacer10,
            const Text(
              "Sign in to continue to your account",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            spacer25,
            CustomTextField(
              controller: _emailController,
              title: "E-Mail",
              topBorder: true,
              validator: (val) {
                if (!isEmail(val)) {
                  return 'Enter valid email';
                }
              },
            ),
            CustomTextField(
              controller: _passController,
              title: "Password",
              bottomBorder: true,
              passwordField: true,
              validator: (val) {
                if (val.isEmpty || val.length < 8) {
                  return 'Password must be at-least 8 characters long';
                }
              },
            ),
            // spacer5,
            // const Align(
            //   alignment: Alignment.centerRight,
            //   child: Text("Forgot Password?"),
            // ),
            spacer25,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state is AuthLoading
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: Center(child: CircularProgressIndicator()))
                    : state is AuthError
                        ? _registerButton(error: state.error)
                        : _registerButton();
              },
            ),
            spacer20,
          ],
        ),
      ),
    );
  }

  _registerButton({String? error}) {
    return Column(
      children: [
        error != null
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.errorRed,
                ),
                child: Text(
                  error,
                  style: const TextStyle(color: AppColors.white),
                ),
              )
            : const SizedBox(),
        spacer10,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              onPressed: () {
                debugPrint('formState ${_formKey.currentState?.validate()}');
                if (_formKey.currentState?.validate() == true) {
                  authBloc.add(SignUpEvent(
                      _emailController.text, _passController.text, context));
                }
              },
              child: const Text("Sign in")),
        ),
      ],
    );
  }
}
