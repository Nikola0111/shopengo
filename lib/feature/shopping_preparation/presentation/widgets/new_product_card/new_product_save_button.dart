import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class NewProductSaveButton extends StatelessWidget {
  const new({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.primaryText,
          shape: const StadiumBorder(),
        ),
        child: Text(LocaleKeys.addProductSheet_saveAndAdd.tr(), style: CustomTextStyles.of(context).semiBold15),
      ),
    );
  }
}
