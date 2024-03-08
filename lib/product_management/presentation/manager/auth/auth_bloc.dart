import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/models/request/sign_in_request.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/check_pin_created_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/check_pin_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/get_user_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/login_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/register_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/set_pin_use_case.dart';
import 'package:crm_machine_test/product_management/injector.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_pages.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //use cases
  final loginUseCase = sl<LoginUseCase>();
  final registerUseCase = sl<RegisterUseCase>();
  final currentUserUseCase = sl<GetUserUseCase>();
  final checkPinCreatedUseCase = sl<CheckPinCreatedUseCase>();
  final checkPinUseCase = sl<CheckPinUseCase>();
  final setPinUseCase = sl<SetPinUseCase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<RegisterInitialEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await registerUseCase.call(SignInRequestModel(
          email: event.email,
          password: event.pass,
        ));
        emit(AuthSuccess());
        Future.delayed(Duration.zero, () {
          GoRouter.of(event.context).pushNamed(AppPages.setPin);
        });
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await loginUseCase.call(SignInRequestModel(
          email: event.email,
          password: event.pass,
        ));
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<GetCurrentUserEvent>((event, emit) async {
      try {
        User? user = await currentUserUseCase.call(NoParams());

        if (user == null) {
          Future.delayed(Duration.zero, () {
            GoRouter.of(event.context).goNamed(AppPages.auth);
          });
        } else {
          try {
            await checkPinCreatedUseCase.call(NoParams());
            Future.delayed(Duration.zero, () {
              GoRouter.of(event.context).goNamed(AppPages.checkPin);
            });
          } catch (e) {
            Future.delayed(Duration.zero, () {
              GoRouter.of(event.context).goNamed(AppPages.setPin);
            });
          }
        }
      } catch (e) {
        Future.delayed(Duration.zero, () {
          GoRouter.of(event.context).goNamed(AppPages.auth);
        });
      }
    });
    on<SetPinEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await setPinUseCase.call(event.pin);
        emit(AuthSuccess());
        Future.delayed(Duration.zero, () {
          GoRouter.of(event.context).goNamed(AppPages.productList);
        });
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<CheckPinEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        var data = await checkPinUseCase.call(event.pin);
        if (data) {
          Future.delayed(Duration.zero, () {
            GoRouter.of(event.context).goNamed(AppPages.productList);
          });
          emit(AuthSuccess());
        } else {
          emit(AuthError("Invalid pin"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
  static AuthBloc get(context) => BlocProvider.of(context);
}
