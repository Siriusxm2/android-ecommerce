import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/services/auth/user_auth_state.dart';

import '../../blocs/blocs.dart';
import '../../utils/dialogs/log_out_dialog.dart';

class ProfileViewLogged extends StatelessWidget {
  const ProfileViewLogged({Key? key}) : super(key: key);

  String get userEmail => AuthService.firebase().currentUser!.email!;
  String? get displayName => AuthService.firebase().currentUser!.displayName;

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
              Navigator.of(context).pushNamedAndRemoveUntil(profileOrdersRoute, (route) => true);
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
              Navigator.of(context).pushNamedAndRemoveUntil(profileSettingsRoute, (route) => true);
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
                context.read<AuthBloc>().add(const AuthLogOut());
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const UserAuthState()), (route) => false);
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
