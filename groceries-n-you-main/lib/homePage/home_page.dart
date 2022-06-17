import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/homePage/scrolling_offers.dart';

import '../myWidgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          SizedBox(height: Dimensions.height15),
          const ScrollingOffers(),
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
