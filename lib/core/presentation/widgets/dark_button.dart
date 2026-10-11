import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

/// Full width dark pill button with an optional leading icon.
class DarkButton extends StatelessWidget {
  const new({
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 54,
    this.textStyle,
    super.key,
  });

  final String text;

  /// Disables the button when null.
  final VoidCallback? onPressed;
  final Widget? icon;
  final double height;

  /// Defaults to semiBold16.
  final TextStyle? textStyle;

  static const double _disabledOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Opacity(
      opacity: onPressed == null ? _disabledOpacity : 1,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: colors.dark,
            foregroundColor: colors.primaryText,
            disabledBackgroundColor: colors.dark,
            disabledForegroundColor: colors.primaryText,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon case final icon?) ...[icon, const SizedBox(width: 10)],
              Flexible(
                child: Text(
                  text,
                  style: textStyle ?? CustomTextStyles.of(context).semiBold16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
