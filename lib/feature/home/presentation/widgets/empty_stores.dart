import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// Shown on the home screen while the user has no stores.
class EmptyStores extends StatelessWidget {
  const new({required this.onAddStorePressed, super.key});

  final VoidCallback onAddStorePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: Center(child: _EmptyMessage())),
        _AddStoreButton(onPressed: onAddStorePressed),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  const new();

  static const double _iconCircleSize = 84;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _iconCircleSize,
            height: _iconCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.background.withValues(alpha: 0.16),
              border: Border.all(color: colors.primaryText.withValues(alpha: 0.2)),
            ),
            child: Icon(Icons.storefront_outlined, size: 36, color: colors.primaryText),
          ),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.home_emptyTitle.tr(),
            textAlign: TextAlign.center,
            style: textStyles.bold20.copyWith(fontSize: 22, height: 1.25),
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.home_emptyDescription.tr(),
            textAlign: TextAlign.center,
            style: textStyles.regular14.copyWith(color: colors.primaryText.withValues(alpha: 0.85), height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _AddStoreButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.accentText,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 20, color: colors.accentText),
            const SizedBox(width: 8),
            Text(
              LocaleKeys.home_addStore.tr(),
              style: CustomTextStyles.of(context).semiBold16.copyWith(color: colors.accentText),
            ),
          ],
        ),
      ),
    );
  }
}
