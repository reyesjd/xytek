import 'package:flutter/material.dart';

class WidgetAppBarBack {
  final Function actionButtonBack;
  final String? title;

  WidgetAppBarBack({required this.actionButtonBack, this.title});

  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
          key: Key("backBtn"),
          color: Colors.black,
          onPressed: () {
            actionButtonBack();
          },
          icon: Icon(Icons.arrow_back)),
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      elevation: 0,
    );
  }
}
