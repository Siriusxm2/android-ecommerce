import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:groceries_n_you/dimensions.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height60,
      width: Dimensions.width60,
      child: FloatingActionButton(
        onPressed: () {
          devtools.log('Button pressed!');
        },
        child: Image.asset(
          'assets/chatButton.png',
          height: Dimensions.height30,
          width: Dimensions.width30,
        ),
        backgroundColor: Colors.white,
        shape: const CircleBorder(
          side: BorderSide(
            color: Color(0xff4382FF),
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
