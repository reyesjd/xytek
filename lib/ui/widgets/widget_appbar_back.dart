import 'package:flutter/material.dart';

class WidgetAppBarBack extends StatelessWidget {
  final Function actionButtonBack;

  WidgetAppBarBack({required this.actionButtonBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
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
