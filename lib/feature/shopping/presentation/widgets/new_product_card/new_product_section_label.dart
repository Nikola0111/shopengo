import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

class NewProductSectionLabel extends StatelessWidget {
  const new({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: CustomTextStyles.of(context).semiBold12
          .copyWith(color: CustomColors.of(context).sectionLabel, letterSpacing: 1),
    );
  }
}
