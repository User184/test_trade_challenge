import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static badSnackBar(BuildContext context, final data) {
    CherryToast.error(
            borderRadius: 12,
            displayCloseButton: false,
            title: "Ошибка",
            description: data,
            animationType: ANIMATION_TYPE.FROM_RIGHT,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true)
        .show(context);
  }

  static goodSnackBar(BuildContext context, final data) {
    CherryToast.success(
            borderRadius: 12,
            displayCloseButton: false,
            title: "Успешно",
            description: data,
            animationType: ANIMATION_TYPE.FROM_RIGHT,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true)
        .show(context);
  }
}
