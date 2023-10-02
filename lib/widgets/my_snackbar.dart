import 'package:flutter/material.dart';

void mySnackbar({required BuildContext context, required String message, SnackBarAction? snackBarAction}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action:snackBarAction,
    ),
  );
}
