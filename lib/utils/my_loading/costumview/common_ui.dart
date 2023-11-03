import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUI {
  static void showToast({required String msg, ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
