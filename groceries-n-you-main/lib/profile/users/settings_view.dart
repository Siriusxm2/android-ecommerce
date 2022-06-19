import 'package:flutter/material.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/utils/dialogs/delete_dialog.dart';

import '../../constants/routes.dart';
import '../../myWidgets/widgets.dart';
import '../../services/crud/orders_service.dart';

class ProfileSettingsView extends StatefulWidget {
  const ProfileSettingsView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: profileSettingsRoute),
      builder: (context) => const ProfileSettingsView(),
    );
  }

  @override
  State<ProfileSettingsView> createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  late final OrdersService _ordersService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _ordersService = OrdersService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Settings'),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  await _ordersService.deleteUser(email: userEmail);
                  await AuthService.firebase().delete();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Delete Account',
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
      ),
    );
  }
}
