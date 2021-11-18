import 'package:flutter/material.dart';

class WidgetAlignText extends StatelessWidget {
  final String text;
  final double size;
  WidgetAlignText({required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
