// Suggested code may be subject to a license. Learn more: ~LicenseLog:3886959905.
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String mensaje){
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(mensaje),
    duration: Duration(seconds: 2),
  ),
);
}