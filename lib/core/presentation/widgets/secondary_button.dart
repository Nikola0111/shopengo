import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

class SecondaryButton extends StatelessWidget {
  const new({
    required this.text,
    required this.onPressed,
    this.height = 36,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: CustomColors.of(context).primaryText, width: 1.5),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(text, style: CustomTextStyles.of(context).medium16),
      ),
    );
  }
}
