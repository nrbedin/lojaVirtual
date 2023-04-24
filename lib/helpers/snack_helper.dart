import 'dart:ffi';

import 'package:flutter/material.dart';

class SnackHelper {
  static void showSnack({
    required BuildContext context,
    required String text,
    Color? color,
    int? duration,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          //style: AppTextStyles.textSnackInformation,
        ),
        backgroundColor: color ?? Theme.of(context).primaryColor,
        duration: Duration(
          seconds: duration ?? 2,
        ),
      ),
    );
  }
}
