import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function validator;
  final bool obscure;
  final bool digitsOnly;
  final Key keyText;
  final int maxLine;

  WidgetTextField(
      {required this.label,
      required this.controller,
      required this.validator,
      required this.obscure,
      required this.digitsOnly,
      this.maxLine=1,
      this.keyText = const Key("")});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        key: keyText,
        maxLines: maxLine,
        obscureText: obscure,
        keyboardType: digitsOnly ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        controller: controller,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
