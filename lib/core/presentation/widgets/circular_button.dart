import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';

class CircularButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.onPressed,
    this.size = 40,
    super.key,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.of(context).background.withValues(alpha: 0.16),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox.square(
          dimension: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
