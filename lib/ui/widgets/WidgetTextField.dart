import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function validator;
  final bool obscure;
  final bool digitsOnly;
  WidgetTextField(
      {required this.label,
      required this.controller,
      required this.validator,
      required this.obscure,
      required this.digitsOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: this.obscure,
        keyboardType: digitsOnly ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: this.label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        controller: controller,
        validator: (value) {
          return this.validator(value);
        },
      ),
    );
  }
}
