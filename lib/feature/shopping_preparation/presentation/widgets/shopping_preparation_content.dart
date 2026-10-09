import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class ShoppingPreparationContent extends StatelessWidget {
  const new({required this.onAddPressed, required this.onStartShoppingPressed, super.key});

  final VoidCallback onAddPressed;
  final VoidCallback onStartShoppingPressed;

  @override
  Widget build(BuildContext context) {
    final surface = CustomColors.of(context).surface;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, max(30, MediaQuery.paddingOf(context).bottom + 12)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [surface.withValues(alpha: 0), surface],
          stops: const [0, 0.35],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AddProductField(onAddPressed: onAddPressed),
          const SizedBox(height: 10),
          _StartShoppingButton(onPressed: onStartShoppingPressed),
        ],
      ),
    );
  }
}

class _AddProductField extends StatelessWidget {
  const new({required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).regular16;
    return Container(
      height: 54,
      padding: const EdgeInsets.only(left: 20, right: 7),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
        boxShadow: const [BoxShadow(color: Color(0x1A3C28A0), offset: Offset(0, 6), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: textStyle.copyWith(color: colors.dark),
              cursorColor: colors.primary,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: LocaleKeys.shoppingPreparation_addProduct.tr(),
                hintStyle: textStyle.copyWith(color: colors.hintText),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: colors.primary,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onAddPressed,
              child: SizedBox.square(dimension: 40, child: Center(child: Assets.icon.plus.svg(width: 20, height: 20))),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartShoppingButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: CustomColors.of(context).dark,
          foregroundColor: CustomColors.of(context).primaryText,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icon.cart.svg(width: 20, height: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                LocaleKeys.shoppingPreparation_startShopping.tr(),
                style: CustomTextStyles.of(context).semiBold16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
