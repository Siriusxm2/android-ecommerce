import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

import '../myWidgets/widgets.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Verify email'),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
              width: Dimensions.width300,
              child: Column(
                children: const [
                  Text(
                    'A verification email has already been sent.',
                  ),
                  Text(
                    'Please verify your email before logging in.',
                  ),
                  Text(
                    'If you do not recieve an email tap on Resend.',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                    await CustomWidgets.mySnackBarWidget(
                      context,
                      'Verification email sent!',
                    );
                  },
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff8EB4FF),
                    side: const BorderSide(
                      color: Color(0xffFFAE2D),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff8EB4FF),
                    side: const BorderSide(
                      color: Color(0xffFFAE2D),
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
