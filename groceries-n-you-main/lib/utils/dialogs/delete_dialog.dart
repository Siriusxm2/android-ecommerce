import 'package:flutter/material.dart';
import 'package:groceries_n_you/utils/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content:
        'Are you sure you want to delete your account? This is IRREVERSIBLE!',
    optionBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}
