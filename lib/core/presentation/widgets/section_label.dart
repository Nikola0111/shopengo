import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

/// Uppercase section title with a colored dot in front.
class SectionLabel extends StatelessWidget {
  const new({required this.title, required this.dotColor, super.key});

  final String title;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: CustomTextStyles.of(context).semiBold12
                .copyWith(color: CustomColors.of(context).sectionLabel, letterSpacing: 1),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
