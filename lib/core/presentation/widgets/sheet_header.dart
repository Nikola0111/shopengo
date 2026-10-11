import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

/// Bottom sheet title with a pill button on the right.
class SheetHeader extends StatelessWidget {
  const new({required this.title, required this.buttonText, required this.onButtonPressed, super.key});

  final String title;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textStyles.semiBold20.copyWith(color: colors.dark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: colors.divider,
            shape: const StadiumBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onButtonPressed,
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                child: Text(buttonText, style: textStyles.medium14.copyWith(color: colors.accentText)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
