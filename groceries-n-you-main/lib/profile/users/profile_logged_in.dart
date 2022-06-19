import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

import '../../utils/dialogs/log_out_dialog.dart';

class ProfileViewLogged extends StatefulWidget {
  const ProfileViewLogged({Key? key}) : super(key: key);

  @override
  State<ProfileViewLogged> createState() => _ProfileViewLoggedState();
}

class _ProfileViewLoggedState extends State<ProfileViewLogged> {
  String get userEmail => AuthService.firebase().currentUser!.email!;
  String? get displayName => AuthService.firebase().currentUser!.displayName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text((displayName != null) ? 'Welcome $displayName' : 'Welcome User'),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'View Orders',
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                profileOrdersRoute,
                (route) => true,
              );
            },
            child: const Text(
              'Order History',
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                profileSettingsRoute,
                (route) => true,
              );
            },
            child: const Text(
              'Settings',
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
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  homeRoute,
                  (_) => false,
                );
              }
            },
            child: const Text(
              'Log out',
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
    );
  }
}
