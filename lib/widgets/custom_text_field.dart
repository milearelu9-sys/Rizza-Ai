import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Color accentColor;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.accentColor,
    this.maxLines = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey[500],
        ),
        filled: true,
        fillColor: const Color(0xFF1A1F3A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[800]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[800]!, width: 1),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
