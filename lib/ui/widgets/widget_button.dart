import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool typeMain;
  final Key keyButton;

  WidgetButton(
      {required this.text,
      required this.onPressed,
      required this.typeMain,
      this.keyButton = const Key("")});

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
                backgroundColor: MaterialStateProperty.all<Color>(typeMain
                    ? Color.fromRGBO(42, 157, 143, 1)
                    : Color.fromRGBO(233, 196, 106, 1))),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              onPressed();
            },
          )),
    );
  }
}
