import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:groceries_n_you/dimensions.dart';

class MyHeaderWidget extends StatelessWidget {
  final String text;

  const MyHeaderWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height50,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: Color(0xffCCCCCC),
              offset: Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Transform.rotate(
                angle: -90 * math.pi / 180,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  icon: const Icon(
                    Icons.expand_less,
                    color: Color(0xff666666),
                    size: 30,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    0,
                    Dimensions.height10,
                    Dimensions.width8,
                    0,
                  ),
                ),
              ),
            ),
            Align(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.font24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width30,
            ),
          ],
        ),
      ),
    );
  }
}
