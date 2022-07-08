import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/customIcons/custom_icons_icons.dart';
import 'package:groceries_n_you/services/auth/auth_exceptions.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/utils/dialogs/loading_dialog.dart';

import '../blocs/blocs.dart';
import '../services/auth/user_auth_state.dart';
import '../utils/dialogs/error_dialog.dart';
import '../myWidgets/widgets.dart';

class ProfileLogin extends StatefulWidget {
  const ProfileLogin({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: loginRoute),
      builder: (context) => const ProfileLogin(),
    );
  }

  @override
  State<ProfileLogin> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileLogin> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscurePassword = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'Could not find a user with the entered credentials!');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong password!');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email!');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error!');
          }
        }
      },
      child: Scaffold(
        appBar: MyAppBarHeader(label: 'Log into your account'),
        drawer: const MyDrawer(),
        floatingActionButton: const MyFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const MyBottomNavbar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width50 / 2),
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Use Facebook or Google to sign in',
                        style: TextStyle(
                          color: const Color(0xff666666),
                          fontSize: Dimensions.font10,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      // Facebook Sign in
                      SizedBox(
                        height: Dimensions.height30,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(const AuthFacebookLogIn());
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserAuthState()));
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: Dimensions.height2 * 2,
                                  left: 0,
                                  child: Image.asset('assets/facebook_logo.png'),
                                ),
                                const Align(
                                  child: Text(
                                    'Sign in with Facebook',
                                    style: TextStyle(color: Color(0xffffffff)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shadowColor: const Color(0xffD8D8D8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.border10),
                            ),
                            primary: const Color(0xff4167B2),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      // Google Sign in
                      SizedBox(
                        height: Dimensions.height30,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(const AuthGoogleLogIn());
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserAuthState()));
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: Dimensions.height5 + Dimensions.height2,
                                  left: 0,
                                  child: Image.asset(
                                    'assets/google_icon.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                                const Align(
                                  child: Text(
                                    'Sign in with Google',
                                    style: TextStyle(color: Color(0xff333333)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.border10),
                            ),
                            primary: const Color(0xffEEEEEE),
                            side: const BorderSide(color: Color(0xffD8D8D8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: const Color(0xffcccccc),
                        endIndent: Dimensions.width5,
                      ),
                    ),
                    Text('or'),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: const Color(0xffcccccc),
                        indent: Dimensions.width5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                // Email field
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Use your email',
                        style: TextStyle(
                          fontSize: Dimensions.font14,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      SizedBox(
                        // width: Dimensions.width300,
                        height: Dimensions.height40,
                        child: TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              Dimensions.width12,
                              0,
                              Dimensions.width10,
                              0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.border10),
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xffD4D4D4),
                              ),
                            ),
                            hintText: 'Enter email...',
                            hintStyle: const TextStyle(
                              color: Color(0xff959595),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                // Password Field
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        // width: Dimensions.width300,
                        height: Dimensions.height40,
                        child: TextField(
                          controller: _password,
                          enableSuggestions: false,
                          obscureText: _obscurePassword,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                              Dimensions.width12,
                              0,
                              Dimensions.width10,
                              0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.border10),
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xffD4D4D4),
                              ),
                            ),
                            hintText: 'Enter password...',
                            hintStyle: const TextStyle(
                              color: Color(0xff959595),
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _obscurePassword ? CustomIcons.eyeOff : CustomIcons.eye,
                                color: const Color(0xff666666),
                                size: 20,
                              ),
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            suffixIconColor: const Color(0xff666666),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      SizedBox(
                        height: Dimensions.height10,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, resetPasswordRoute, (route) => true);
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'Forgotten password? Click here.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: const Color(0xff333333),
                              fontSize: Dimensions.font10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                // LOGIN Button
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            final email = _email.text;
                            final password = _password.text;

                            context.read<AuthBloc>().add(AuthLogIn(email: email, password: password));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const UserAuthState()), (route) => false);
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Color(0xff333333),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.border10),
                            ),
                            primary: const Color(0xff8EB4FF),
                            side: const BorderSide(
                              color: Color(0xffFFAE2D),
                            ),
                            minimumSize: Size.fromHeight(Dimensions.height30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, registerRoute, (route) => true);
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'No profile? Register here.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: const Color(0xff333333),
                              fontSize: Dimensions.font10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
