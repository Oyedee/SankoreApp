import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    padding: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(30),
    elevation: 20,
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
