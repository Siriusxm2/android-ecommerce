import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';

class MyBottomNavbar extends StatelessWidget {
  const MyBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height120 + Dimensions.height3,
      child: BottomAppBar(
        color: const Color(0xff8EB4FF),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height40,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != aboutRoute) {
                    Navigator.of(context).pushNamed(aboutRoute);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Text(
                        'ABOUT US',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: const Color(
                            0xff000000,
                          ),
                          fontSize: Dimensions.font12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: const Icon(
                        Icons.expand_less,
                        color: Color(0xff666666),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              indent: Dimensions.width15,
              endIndent: Dimensions.width15,
              height: 1,
              thickness: 1,
              color: const Color(0xffB4CDFF),
            ),
            SizedBox(
              height: Dimensions.height40,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != contactRoute) {
                    Navigator.of(context).pushNamed(contactRoute);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Text(
                        'CONTACT AND HELP',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: const Color(
                            0xff000000,
                          ),
                          fontSize: Dimensions.font12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: const Icon(
                        Icons.expand_less,
                        color: Color(0xff666666),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              indent: Dimensions.width15,
              endIndent: Dimensions.width15,
              height: 1,
              thickness: 1,
              color: const Color(0xffB4CDFF),
            ),
            Container(
              height: Dimensions.height40,
              alignment: AlignmentDirectional.center,
              child: Text(
                'All rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff000000),
                  fontSize: Dimensions.font10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
