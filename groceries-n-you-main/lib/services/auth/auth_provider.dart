import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries_n_you/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({required String email, required String password});

  Future<AuthUser> createUser({required String name, required String email, required String password});

  Future<void> logOut();

  Future<void> delete();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset({required String toEmail});

  Future<UserCredential?> signInWithFacebook();

  Future<UserCredential?> signInWithGoogle();
}
