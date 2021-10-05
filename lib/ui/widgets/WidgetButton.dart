import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool type_main;

  WidgetButton(
      {required this.text, required this.onPressed, required this.type_main});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 47,
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(type_main
                    ? Color.fromRGBO(42, 157, 143, 1)
                    : Color.fromRGBO(233, 196, 106, 1))),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              this.onPressed();
            },
          )),
    );
  }
}
