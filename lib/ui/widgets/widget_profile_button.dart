import 'package:flutter/material.dart';

class WidgetProfileButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Key keyProfileButton;

  WidgetProfileButton(
      {required this.text,
      required this.onPressed,
      this.keyProfileButton = const Key("")});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromRGBO(228, 228, 225, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        key: keyProfileButton,
        onPressed: () {
          onPressed();
        },
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(text,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(51, 51, 51, 1))),
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.arrow_forward_ios_outlined,
                        size: 25, color: Color.fromRGBO(51, 51, 51, 1))))
          ],
        ),
      ),
    );
  }
}
