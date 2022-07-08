import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../dimensions.dart';
import '../services/auth/user_auth_state.dart';

class CartEmptyPage extends StatelessWidget {
  const CartEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          top: Dimensions.height60,
        ),
        child: Column(
          children: [
            Text(
              'КОЛИЧКАТА ВИ Е ПРАЗНА',
              style: TextStyle(
                fontSize: Dimensions.font24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Dimensions.height30),
            Text(
              'Добавете продукт към количката преди да продължите.',
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
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const UserAuthState()), (route) => false);
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
    );
  }
}
