import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries_n_you/services/auth/auth_exceptions.dart';
import 'package:groceries_n_you/services/auth/auth_provider.dart';
import 'package:groceries_n_you/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(provider._isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to initialize in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        name: 'Test',
        email: 'foo@bar.com',
        password: '1232132',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );
      final badPasswordUser = provider.createUser(
        name: 'Test',
        email: 'some@email.com',
        password: 'foobar',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
      final user = await provider.createUser(
        name: 'Test',
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to log out and log in again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'pass',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });

    test('Should be able to send password reset email', () async {
      final badEmail = provider.sendPasswordReset(toEmail: 'foobar');
      expect(
        badEmail,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      await provider.sendPasswordReset(toEmail: 'foo');
      expect(provider.didSend, true);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  bool _isInitialized = false;
  bool _didSend = false;
  AuthUser? _user;

  bool get isInitialized => _isInitialized;
  bool get didSend => _didSend;

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<AuthUser> createUser({required String name, required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(id: 'jashd2xf3', email: 'foo', isEmailVerified: false, displayName: 'Test');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(id: 'jashd2xf3', email: 'foo', isEmailVerified: true, displayName: 'Test');
    _user = newUser;
  }

  @override
  Future<UserCredential?> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    if (!isInitialized) throw NotInitializedException();
    if (toEmail == 'foobar') throw UserNotFoundAuthException();
    _didSend = true;
  }
}
