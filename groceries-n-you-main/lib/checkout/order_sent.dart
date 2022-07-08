import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../dimensions.dart';
import '../myWidgets/widgets.dart';

class OrderSentPage extends StatelessWidget {
  const OrderSentPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: orderSuccessRoute),
      builder: (context) => const OrderSentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.height60, left: Dimensions.width10, right: Dimensions.width10),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - Dimensions.width20,
                child: Image.asset(
                  'assets/order_succ_ad.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: Dimensions.height5),
              Text(
                'ПОРЪЧКАТА Е ИЗПРАТЕНА УСПЕШНО',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.font24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Text(
                'Ще получите имейл за потвърждение скоро.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Dimensions.height20),
              SizedBox(
                height: Dimensions.height40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'КЪМ НАЧАЛНАТА СТРАНИЦА',
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
      ),
    );
  }
}
