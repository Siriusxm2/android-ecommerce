import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../dimensions.dart';
import '../myWidgets/widgets.dart';

class OrderSentPage extends StatelessWidget {
  const OrderSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.height60,
                bottom: Dimensions.height5,
              ),
              width: MediaQuery.of(context).size.width - Dimensions.width20,
              child: Image.asset(
                'assets/order_succ_ad.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: Dimensions.height30,
              ),
              child: Text(
                'ORDER SENT SUCCESSFULLY',
                style: TextStyle(
                  fontSize: Dimensions.font24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height20),
              child: Text(
                'You should recieve a confirmation email shortly.',
                style: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height40,
              width: Dimensions.width80 * 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoute,
                    (route) => false,
                  );
                },
                child: Text(
                  'BACK TO HOME PAGE',
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff8EB4FF),
                  side: const BorderSide(
                    color: Color(0xffFFAE2D),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
