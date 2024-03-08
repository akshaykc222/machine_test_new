part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  final String email;
  final String pass;
  final BuildContext context;
  LoginEvent(this.email, this.pass, this.context);
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String pass;
  final BuildContext context;

  SignUpEvent(this.email, this.pass, this.context);

  @override
  List<Object?> get props => [email, pass];
}

class RegisterInitialEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserEvent extends AuthEvent {
  final BuildContext context;

  GetCurrentUserEvent(this.context);

  @override
  List<Object?> get props => [];
}

class SetPinEvent extends AuthEvent {
  final String pin;
  final BuildContext context;
  SetPinEvent(this.pin, this.context);

  @override
  List<Object?> get props => [];
}

class CheckPinEvent extends AuthEvent {
  final String pin;
  final BuildContext context;

  CheckPinEvent({required this.pin, required this.context});

  @override
  List<Object?> get props => [];
}
