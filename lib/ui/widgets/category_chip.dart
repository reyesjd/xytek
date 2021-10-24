import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CategoryChip({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
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
