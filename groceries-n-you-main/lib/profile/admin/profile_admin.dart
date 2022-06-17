import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/myWidgets/my_header.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

import '../../utils/dialogs/log_out_dialog.dart';

class ProfileAdminView extends StatelessWidget {
  const ProfileAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const MyHeaderWidget(text: 'Admin Panel'),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'View Products',
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
