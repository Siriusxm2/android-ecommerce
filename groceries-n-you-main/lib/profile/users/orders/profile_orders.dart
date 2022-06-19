import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/services/crud/orders_service.dart';

import '../../../myWidgets/widgets.dart';

class ProfileOrdersPage extends StatefulWidget {
  const ProfileOrdersPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: profileOrdersRoute),
      builder: (context) => const ProfileOrdersPage(),
    );
  }

  @override
  State<ProfileOrdersPage> createState() => _ProfileOrdersPageState();
}

class _ProfileOrdersPageState extends State<ProfileOrdersPage> {
  String get userEmail => AuthService.firebase().currentUser!.email!;
  late final OrdersService _ordersService;

  @override
  void initState() {
    _ordersService = OrdersService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Order history'),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Column(
        children: [
          FutureBuilder(
            future: _ordersService.getUser(email: userEmail),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return StreamBuilder(
                    stream: _ordersService.allProducts,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text('No previous orders.');
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final allProducts =
                                snapshot.data as List<DatabaseProduct>;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: allProducts.length,
                              itemBuilder: (context, index) {
                                final prod = allProducts[index];
                                return ListTile(
                                  title: Text(
                                    prod.toString(),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  );
                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
