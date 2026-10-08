import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
    this.size = 48,
    super.key,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}
