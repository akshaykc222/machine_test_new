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
