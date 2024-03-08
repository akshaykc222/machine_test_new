import 'package:crm_machine_test/product_management/presentation/manager/auth/auth_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_pages.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_constants.dart';
import 'package:crm_machine_test/product_management/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthMobile extends StatefulWidget {
  const AuthMobile({super.key});

  @override
  State<AuthMobile> createState() => _AuthMobileState();
}

class _AuthMobileState extends State<AuthMobile> {
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
        automaticallyImplyLeading: false,
        // leading: const Icon(LineAwesomeIcons.arrow_left),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            spacer50,
            const Text(
              "Welcome Back,",
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
            spacer5,
            // const Align(
            //   alignment: Alignment.centerRight,
            //   child: Text("Forgot Password?"),
            // ),
            spacer25,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state is AuthLoading
                    ? const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      )
                    : state is AuthError
                        ? _loginButton(error: state.error)
                        : _loginButton();
              },
            ),
            spacer20,
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(AppPages.register);
              },
              child: RichText(
                text: const TextSpan(
                  text: "Don't have an account ? ",
                  style: TextStyle(color: AppColors.dartGrey, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.enableButtonColor)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _loginButton({String? error}) {
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
                  authBloc.add(LoginEvent(
                      _emailController.text, _passController.text, context));
                }
              },
              child: const Text("Sign in")),
        ),
      ],
    );
  }
}
