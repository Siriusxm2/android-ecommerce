import 'package:flutter/material.dart';
import 'package:groceries_n_you/utils/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Sign Out',
    content: 'Are you sure you want to sign out?',
    optionBuilder: () => {
      'Cancel': false,
      'Log Out': true,
    },
  ).then((value) => value ?? false);
}
