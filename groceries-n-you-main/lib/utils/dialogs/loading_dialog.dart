import 'package:flutter/material.dart';

import '../../dimensions.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog(BuildContext context, String text) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        SizedBox(height: Dimensions.height10),
        Text(text),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
