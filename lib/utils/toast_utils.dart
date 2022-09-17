import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {

  static void showToast(String text,{bool isError = false, bool isLong = false, ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.black54,
      textColor: Colors.white,
    );
  }

  static void showLongToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: "Please check your internet connection",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
