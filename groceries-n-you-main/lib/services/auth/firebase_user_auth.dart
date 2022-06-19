import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/homePage/home_page.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';

class MyFirebaseUserAuth extends StatelessWidget {
  const MyFirebaseUserAuth({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: initRoute),
      builder: (_) => const MyFirebaseUserAuth(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // return const InitDbProducts();
            return const HomePage();
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
