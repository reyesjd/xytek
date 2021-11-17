import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CustomSnackbarType { success, error, info }

Icon getIcon(CustomSnackbarType type) {
  switch (type) {
    case CustomSnackbarType.success:
      return Icon(
        Icons.check_circle,
        color: Colors.green[700],
        size: 30,
      );
    case CustomSnackbarType.error:
      return Icon(
        Icons.error,
        color: Colors.red[700],
        size: 30,
      );
    case CustomSnackbarType.info:
      return Icon(
        Icons.info,
        color: Colors.blue[700],
        size: 30,
      );
    default:
      return Icon(
        Icons.info,
        color: Colors.blue[700],
        size: 30,
      );
  }
}

void getCustomSnackbar(String title, String message,
    {CustomSnackbarType type = CustomSnackbarType.success,
    Duration? duration,
    bool? showProgressIndicator}) {
  return Get.snackbar(
    title,
    message,
    shouldIconPulse: false,
    icon: getIcon(type),
    backgroundColor: Colors.grey[200],
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderColor: Color.fromRGBO(0, 0, 0, 0.15),
    borderWidth: 0.5,
    boxShadows: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        offset: Offset(0, 1),
        blurRadius: 4,
        spreadRadius: 0,
      )
    ],
    duration: duration,
    showProgressIndicator: showProgressIndicator,
  );
}
