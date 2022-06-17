import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/myWidgets/my_header.dart';

class ProfileViewNotLogged extends StatelessWidget {
  const ProfileViewNotLogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              const MyHeaderWidget(
                text: 'Profile',
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => true);
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => true);
                },
                child: const Text(
                  'Register',
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
    );
  }
}
