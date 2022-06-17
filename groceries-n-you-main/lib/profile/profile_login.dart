import 'package:flutter/material.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/customIcons/custom_icons_icons.dart';
import 'package:groceries_n_you/services/auth/auth_exceptions.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

import '../utils/dialogs/error_dialog.dart';
import '../myWidgets/widgets.dart';

class ProfileLogin extends StatefulWidget {
  const ProfileLogin({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Log in to your account'),
      body: Center(
        child: Column(
          children: [
            // Facebook Sign in
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await AuthService.firebase().signInWithFacebook();
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    await CustomWidgets.mySnackBarWidget(
                      context,
                      'Logged in successfully!',
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  await showErrorDialog(
                    context,
                    'No user found!',
                  );
                } on WrongPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'Wrong password!',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'Invalid email!',
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    'Authentication error',
                  );
                }
              },
              icon: Image.asset('assets/facebook_logo.png'),
              label: Row(
                children: const [
                  Text(
                    'Sign in with Facebook',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.border10),
                ),
                primary: const Color(0xff4167B2),
                fixedSize: Size(Dimensions.width340, Dimensions.height30),
              ),
            ),
            // Google Sign in
            ElevatedButton(
              onPressed: () async {
                try {
                  await AuthService.firebase().signInWithGoogle();
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    await CustomWidgets.mySnackBarWidget(
                      context,
                      'Logged in successfully!',
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  await showErrorDialog(
                    context,
                    'No user found!',
                  );
                } on WrongPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'Wrong password!',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'Invalid email!',
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    'Authentication error',
                  );
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/google_icon.png',
                    width: 16,
                    height: 16,
                  ),
                  const Center(
                    child: Text(
                      'Sign in with Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.border10),
                ),
                primary: const Color(0xffEEEEEE),
                side: const BorderSide(
                  color: Color(0xffD8D8D8),
                ),
                fixedSize: Size(Dimensions.width340, Dimensions.height30),
              ),
            ),
            Container(
              width: Dimensions.width300,
              height: Dimensions.height30,
              margin: EdgeInsets.fromLTRB(
                0,
                Dimensions.height10,
                0,
                Dimensions.height5,
              ),
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
            Container(
              width: Dimensions.width300,
              height: Dimensions.height30,
              margin: EdgeInsets.fromLTRB(
                0,
                Dimensions.height5,
                0,
                Dimensions.height10,
              ),
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
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().logIn(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        await CustomWidgets.mySnackBarWidget(
                          context,
                          'Logged in successfully!',
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          homeRoute,
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyRoute,
                          (route) => false,
                        );
                      }
                    } on UserNotFoundAuthException {
                      await showErrorDialog(
                        context,
                        'No user found!',
                      );
                    } on WrongPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Wrong password!',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                        'Invalid email!',
                      );
                    } on GenericAuthException {
                      showErrorDialog(
                        context,
                        'Authentication error',
                      );
                    }
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
                    fixedSize: Size(Dimensions.width340, Dimensions.height30),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => true,
                    );
                  },
                  child: Container(
                    width: Dimensions.width340,
                    padding: EdgeInsets.only(left: Dimensions.width10),
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
          ],
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
