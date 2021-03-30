import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showTip(String tipMessage) {
  Fluttertoast.showToast(
      msg: tipMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER);
}

void showError(String errorMessage) {
  Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}
