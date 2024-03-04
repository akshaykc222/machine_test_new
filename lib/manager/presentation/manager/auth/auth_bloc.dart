import 'package:crm_machine_test/manager/data/models/request/sign_in_request.dart';
import 'package:crm_machine_test/manager/domain/use_cases/login_use_case.dart';
import 'package:crm_machine_test/manager/domain/use_cases/register_use_case.dart';
import 'package:crm_machine_test/manager/injector.dart';
import 'package:crm_machine_test/manager/presentation/router/app_pages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //use cases
  final loginUseCase = sl<LoginUseCase>();
  final registerUseCase = sl<RegisterUseCase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      print(
          " email: ${event.email}, password: ${event.pass}, role: ${UserRoles.admin}");
      try {
        await registerUseCase
            .call(SignInRequestModel(
                email: event.email,
                password: event.pass,
                role: UserRoles.admin))
            .then((value) =>
                GoRouter.of(event.context).pushNamed(AppPages.dashboard));
      } catch (e) {
        print(e);
        emit(AuthError(e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      print(
          " email: ${event.email}, password: ${event.pass}, role: ${UserRoles.admin}");
      try {
        loginUseCase
            .call(SignInRequestModel(
                email: event.email,
                password: event.pass,
                role: UserRoles.admin))
            .then((value) =>
                GoRouter.of(event.context).pushNamed(AppPages.dashboard));
      } catch (e) {
        print(e);
        emit(AuthError(e.toString()));
      }
    });
  }
  static AuthBloc get(context) => BlocProvider.of(context);
}
