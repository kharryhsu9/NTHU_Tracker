import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color background;
  final VoidCallback onClicked;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.background,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
          backgroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      child: Text(text, style: TextStyle(fontSize: 16, color: color)),
    );
  }
}
