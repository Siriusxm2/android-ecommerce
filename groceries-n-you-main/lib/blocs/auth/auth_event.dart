part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthInitialState extends AuthEvent {
  const AuthInitialState();
}

class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLogIn({required this.email, required this.password});
}

class AuthShouldLogIn extends AuthEvent {
  const AuthShouldLogIn();
}

class AuthFacebookLogIn extends AuthEvent {
  const AuthFacebookLogIn();
}

class AuthGoogleLogIn extends AuthEvent {
  const AuthGoogleLogIn();
}

class AuthLogOut extends AuthEvent {
  const AuthLogOut();
}

class AuthSendEmailVerificaiton extends AuthEvent {
  const AuthSendEmailVerificaiton();
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthRegister({required this.email, required this.password, required this.name});
}

class AuthShouldRegister extends AuthEvent {
  const AuthShouldRegister();
}
