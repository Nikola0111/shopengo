import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// Shown in place of the shopping list while the store's cart is empty.
class EmptyShoppingList extends StatelessWidget {
  const new({super.key});

  static const double _iconCircleSize = 68;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 56, 32, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _iconCircleSize,
            height: _iconCircleSize,
            decoration: BoxDecoration(color: colors.highlight, shape: BoxShape.circle),
            child: Center(
              child: Assets.icon.cart.svg(
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            LocaleKeys.shoppingPreparation_emptyCart.tr(),
            textAlign: TextAlign.center,
            style: textStyles.bold20.copyWith(fontSize: 18, color: colors.dark),
          ),
          const SizedBox(height: 6),
          Text(
            LocaleKeys.shoppingPreparation_emptyCartDescription.tr(),
            textAlign: TextAlign.center,
            style: textStyles.regular14.copyWith(color: colors.bodyText, height: 1.45),
          ),
        ],
      ),
    );
  }
}
