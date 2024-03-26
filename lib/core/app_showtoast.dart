import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppShowToast {
  AppShowToast._();

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 15.0,
    );
  }
}