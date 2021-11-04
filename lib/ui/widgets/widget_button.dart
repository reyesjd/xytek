import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool typeMain;
  final Key keyButton;
  final bool loading;

  WidgetButton(
      {required this.text,
      required this.onPressed,
      required this.typeMain,
      this.loading = false,
      this.keyButton = const Key("")});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 47,
        margin: EdgeInsets.all(10),
        child: ElevatedButton(
          key: keyButton,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(typeMain
                ? Color.fromRGBO(42, 157, 143, loading ? 0.6 : 1)
                : Color.fromRGBO(233, 196, 106, loading ? 0.6 : 1)),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: loading ? null : onPressed,
        ),
      ),
    );
  }
}
