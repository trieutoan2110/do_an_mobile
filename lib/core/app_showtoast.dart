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

  static void showAlert(
      BuildContext context, String title, String content, String titleAction1,
      String titleAction2, VoidCallback action1, VoidCallback action2) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: action1,
              child: Text(titleAction1),
            ),
            TextButton(
              onPressed: action2,
              child: Text(titleAction2),
            ),
          ],
        );
      },
    );
  }
}