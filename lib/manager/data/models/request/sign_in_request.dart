class SignInRequestModel {
  final String email;
  final String password;
  final UserRoles role;

  SignInRequestModel(
      {required this.email, required this.password, required this.role});
}

enum UserRoles { admin, manager }
