import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/cart/cart_empty.dart';
import 'package:groceries_n_you/cart/cart_full_page.dart';
import 'package:groceries_n_you/constants/routes.dart';

import '../blocs/blocs.dart';
import '../myWidgets/widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: cartRoute),
      builder: (context) => const CartPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Your Cart'),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartLoaded) {
          return Column(
            children: [
              state.cart.productQuantity(state.cart.products).keys.isEmpty
                  ? const CartEmptyPage()
                  : const CartFullPage(),
            ],
          );
        } else {
          return const Text('Something went wrong!');
        }
      }),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
