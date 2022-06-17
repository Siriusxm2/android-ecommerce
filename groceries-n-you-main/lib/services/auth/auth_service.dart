import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries_n_you/services/auth/auth_provider.dart';
import 'package:groceries_n_you/services/auth/auth_user.dart';
import 'package:groceries_n_you/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> createUser({
    required String name,
    required String email,
    required String password,
  }) =>
      provider.createUser(
        name: name,
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> delete() => provider.delete();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<UserCredential?> signInWithFacebook() => provider.signInWithFacebook();

  @override
  Future<UserCredential?> signInWithGoogle() => provider.signInWithGoogle();
}
