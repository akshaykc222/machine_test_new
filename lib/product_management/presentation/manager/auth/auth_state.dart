part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthSuccess extends AuthState {}

class AuthLoading extends AuthState {}
