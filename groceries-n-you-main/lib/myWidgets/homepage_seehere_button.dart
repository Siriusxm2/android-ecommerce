import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';

class MySeeHereButton extends StatelessWidget {
  void Function() onPressed;

  MySeeHereButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'ВИЖ ТУК',
        style: TextStyle(
          color: const Color(0xff333333),
          fontSize: Dimensions.font10,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.border5),
        ),
        primary: const Color(0xffFFBE57),
        side: const BorderSide(
          width: 0.5,
          color: Color(0xff699BFF),
        ),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        fixedSize: const Size(70, 20),
      ),
    );
  }
}
