import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/utils/dialogs/error_dialog.dart';

import '../blocs/blocs.dart';
import '../myWidgets/widgets.dart';
import '../utils/dialogs/password_reset_email_sent_dialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: resetPasswordRoute),
      builder: (context) => const ResetPassword(),
    );
  }

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context, 'We could not proccess your request. Please make sure you are a registered user. If not, register a user now.');
          }
        }
      },
      child: Scaffold(
        appBar: MyAppBarHeader(label: 'Forgot Password'),
        drawer: const MyDrawer(),
        floatingActionButton: const MyFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const MyBottomNavbar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width15, vertical: Dimensions.height15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  width: Dimensions.width300,
                  child: Column(
                    children: [
                      const Text('Enter email you forgot the password to.'),
                      Container(
                        width: Dimensions.width300,
                        height: Dimensions.height30,
                        margin: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height5),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: Dimensions.width12, right: Dimensions.width10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.border10)),
                              borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                            ),
                            hintText: 'Enter email...',
                            hintStyle: const TextStyle(color: Color(0xff959595)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final email = _controller.text;
                              context.read<AuthBloc>().add(AuthResetPassword(email: email));
                            },
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(color: Color(0xff333333)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff8EB4FF),
                              side: const BorderSide(color: Color(0xffFFAE2D)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                            },
                            child: const Text(
                              'Back to Login',
                              style: TextStyle(color: Color(0xff333333)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff8EB4FF),
                              side: const BorderSide(color: Color(0xffFFAE2D)),
                            ),
                          ),
                        ],
                      )
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
