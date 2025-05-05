import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextButton(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(backgroundColor)),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}
