import 'package:flutter/material.dart';
import 'package:groceries_n_you/utils/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content: 'Password reset link has been sent! Check your email.',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
