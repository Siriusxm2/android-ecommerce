import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/profile/profile_email_verify.dart';
import 'package:groceries_n_you/profile/users/profile_logged_in.dart';
import 'package:groceries_n_you/profile/guests/profile_not_logged_in.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

import '../myWidgets/widgets.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: profileRoute),
      builder: (context) => ProfileView(),
    );
  }

  final user = AuthService.firebase().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Profile'),
      body: (user != null)
          ? (user!.isEmailVerified)
              ? const ProfileViewLogged()
              : const VerifyEmail()
          : const ProfileViewNotLogged(),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
