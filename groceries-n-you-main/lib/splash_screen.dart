import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';

import 'constants/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context)
          .pushNamedAndRemoveUntil(homeRoute, (route) => false),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width12 / 2),
              child: Image(
                image: const AssetImage('assets/logo.png'),
                width: Dimensions.width100,
                height: Dimensions.height50 * 2,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height50 / 2),
          Column(
            children: [
              Text(
                'GROCERIES',
                style: TextStyle(
                  color: const Color(0xffFFAE2D),
                  fontSize: Dimensions.font24 + Dimensions.font12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'N',
                style: TextStyle(
                  color: const Color(0xff333333),
                  fontSize: Dimensions.font24 + (Dimensions.font12 / 2),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'YOU',
                style: TextStyle(
                  color: const Color(0xff4382FF),
                  fontSize: Dimensions.font24 + Dimensions.font24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
