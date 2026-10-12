import 'dart:math';

import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/core/presentation/widgets/dark_button.dart';
import 'package:basketwise/generated/assets.gen.dart';
import 'package:basketwise/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Actions under the list, fading into the list above them.
class ShoppingBottomBar extends StatelessWidget {
  const new({
    required this.isShopping,
    required this.onAddPressed,
    required this.onStartShoppingPressed,
    required this.onFinishShoppingPressed,
    super.key,
  });

  /// Whether the list is being shopped, as opposed to prepared.
  final bool isShopping;
  final VoidCallback onAddPressed;

  /// Disables the start shopping button when null.
  final VoidCallback? onStartShoppingPressed;
  final VoidCallback onFinishShoppingPressed;

  static const Color _shadowColor = Color(0x1A3C28A0);

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
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.bottomCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isShopping
              ? _ShoppingActions(onAddPressed: onAddPressed, onFinishShoppingPressed: onFinishShoppingPressed)
              : _PreparationActions(onAddPressed: onAddPressed, onStartShoppingPressed: onStartShoppingPressed),
        ),
      ),
    );
  }
}

class _PreparationActions extends StatelessWidget {
  const new({required this.onAddPressed, required this.onStartShoppingPressed});

  final VoidCallback onAddPressed;
  final VoidCallback? onStartShoppingPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AddProductField(onAddPressed: onAddPressed),
        const SizedBox(height: 10),
        DarkButton(
          text: LocaleKeys.shoppingPreparation_startShopping.tr(),
          icon: Assets.icon.cart.svg(width: 20, height: 20),
          onPressed: onStartShoppingPressed,
        ),
      ],
    );
  }
}

class _ShoppingActions extends StatelessWidget {
  const new({required this.onAddPressed, required this.onFinishShoppingPressed});

  final VoidCallback onAddPressed;
  final VoidCallback onFinishShoppingPressed;

  static const double _height = 54;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Row(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: ShoppingBottomBar._shadowColor, offset: Offset(0, 6), blurRadius: 10)],
          ),
          child: Material(
            color: colors.background,
            shape: CircleBorder(side: BorderSide(color: colors.border)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onAddPressed,
              splashColor: colors.highlight,
              child: SizedBox.square(
                dimension: _height,
                child: Center(
                  child: Assets.icon.plus.svg(
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DarkButton(
            text: LocaleKeys.shoppingInProgress_finishShopping.tr(),
            onPressed: onFinishShoppingPressed,
          ),
        ),
      ],
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
    return GestureDetector(
      onTap: onAddPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 54,
        padding: const EdgeInsets.only(left: 20, right: 7),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: colors.border),
          boxShadow: const [BoxShadow(color: ShoppingBottomBar._shadowColor, offset: Offset(0, 6), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.shoppingPreparation_addProduct.tr(),
                style: textStyle.copyWith(color: colors.hintText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
              child: Center(child: Assets.icon.plus.svg(width: 20, height: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
