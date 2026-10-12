import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductNameField extends StatelessWidget {
  const new({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    this.onEditingComplete,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).regular17;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
      ),
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        style: textStyle.copyWith(color: colors.dark),
        cursorColor: colors.primary,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: LocaleKeys.addProductSheet_productNameHint.tr(),
          hintStyle: textStyle.copyWith(color: colors.hintText),
        ),
      ),
    );
  }
}
