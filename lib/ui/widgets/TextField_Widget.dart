import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function validator;
  final bool obscure;
  TextFieldWidget(
      {required this.label,
      required this.controller,
      required this.validator,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: this.obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: this.label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        controller: controller,
        validator: (value) {
          validator(value);
        },
      ),
    );
  }
}
