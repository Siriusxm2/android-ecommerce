import 'package:bloc/bloc.dart';
import 'package:groceries_n_you/services/auth/auth_provider.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
    // email verification
    on<AuthSendEmailVerificaiton>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });
    // initial
    on<AuthInitialState>((event, emit) async {
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    });
    // log in
    on<AuthLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true, loadingText: 'Please wait. Logging you in.'));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
    // facebook login
    on<AuthFacebookLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true, loadingText: 'Please wait. Logging you in.'));
      try {
        final user = await provider.signInWithFacebook();
        if (!user!.user!.emailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
    // google login
    on<AuthGoogleLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true, loadingText: 'Please wait. Logging you in.'));
      try {
        final user = await provider.signInWithGoogle();
        if (!user!.user!.emailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
    // register
    on<AuthRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      final name = event.name;

      try {
        await provider.createUser(name: name, email: email, password: password);
        await provider.sendEmailVerification();
        emit(const AuthStateNeedVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });
    // log out
    on<AuthLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
    // reset password
    on<AuthResetPassword>((event, emit) async {
      emit(const AuthStateForgotPassword(exception: null, hasSentEmail: false, isLoading: false));
      final email = event.email;
      if (email == null) {
        return;
      }
      emit(const AuthStateForgotPassword(exception: null, hasSentEmail: false, isLoading: true));

      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }

      emit(AuthStateForgotPassword(exception: exception, hasSentEmail: didSendEmail, isLoading: false));
    });
  }
  // final AuthRepository _authRepository;
  // final UserRepository _userRepository;
  // StreamSubscription<auth.User?>? _authUserSubscription;
  // StreamSubscription<UserModel?>? _userSubscription;

  // AuthBloc({
  //   required AuthRepository authRepository,
  //   required UserRepository userRepository,
  // })  : _authRepository = authRepository,
  //       _userRepository = userRepository,
  //       super(const AuthStateAuthentication.unknown()) {
  //   on<AuthUserChanged>(_onAuthUserChanged);

  //   _authUserSubscription = _authRepository.user.listen((authUser) {
  //     print('Auth user: $authUser');
  //     if (authUser != null) {
  //       _userRepository.getUser(authUser.uid).listen((user) {
  //         add(AuthUserChanged(authUser: authUser, user: user));
  //       });
  //     } else {
  //       add(AuthUserChanged(authUser: authUser));
  //     }
  //   });
  // }

  // void _onAuthUserChanged(
  //   AuthUserChanged event,
  //   Emitter<AuthState> emit,
  // ) {
  //   event.authUser != null ? emit(AuthStateAuthentication.authenticated(authUser: event.authUser!, user: event.user!)) : emit(const AuthStateAuthentication.unauthenticated());
  // }

  // @override
  // Future<void> close() {
  //   _authUserSubscription?.cancel();
  //   _userSubscription?.cancel();
  //   return super.close();
  // }
}
