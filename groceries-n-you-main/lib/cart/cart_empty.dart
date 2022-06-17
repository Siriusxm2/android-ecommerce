import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../dimensions.dart';

class CartEmptyPage extends StatelessWidget {
  const CartEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.height60,
                  bottom: Dimensions.height30,
                ),
                child: Text(
                  'YOUR CART IS EMPTY',
                  style: TextStyle(
                    fontSize: Dimensions.font24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height20),
                child: Text(
                  'Add a product to your cart before you continue',
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
        ],
      ),
    );
  }
}
