import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Key categoryKey;

  CategoryChip(
      {required this.label,
      required this.onPressed,
      required this.categoryKey});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      key: categoryKey,
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
