import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Key key;

  CategoryChip(
      {required this.label, required this.onPressed, required this.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      key: key,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      side: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
      label: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
