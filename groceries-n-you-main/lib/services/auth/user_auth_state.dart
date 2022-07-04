import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/homePage/home_page.dart';
import 'package:groceries_n_you/myWidgets/widgets.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../profile/profile_email_verify.dart';
import '../../profile/profile_register.dart';

class UserAuthState extends StatelessWidget {
  const UserAuthState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthInitialState());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(context: context, text: state.loadingText ?? 'Please wait a moment');
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomePage();
        } else if (state is AuthStateRegistering) {
          return const ProfileRegister();
        } else if (state is AuthStateLoggedOut) {
          return const HomePage();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmail();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
