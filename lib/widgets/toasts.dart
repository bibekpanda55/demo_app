import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color(0xFFff0800),
    textColor: const Color(0xFFFFFFFF),
    gravity: ToastGravity.BOTTOM,
    fontSize: 14.0,
  );
}

void showSuccessToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color(0xFF4cbb17),
    textColor: const Color(0xFFFFFFFF),
    gravity: ToastGravity.BOTTOM,
    fontSize: 14.0,
  );
}

void showInfoToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color(0xff6C63FF),
    textColor: const Color(0xFFFFFFFF),
    gravity: ToastGravity.BOTTOM,
    fontSize: 14.0,
  );
}
