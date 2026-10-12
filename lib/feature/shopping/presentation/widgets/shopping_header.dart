import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/core/presentation/widgets/amount_text.dart';
import 'package:basketwise/core/presentation/widgets/circular_button.dart';
import 'package:basketwise/core/presentation/widgets/secondary_button.dart';
import 'package:basketwise/feature/home/domain/model/store_model.dart';
import 'package:basketwise/generated/assets.gen.dart';
import 'package:basketwise/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShoppingHeader extends StatelessWidget {
  const new({
    required this.store,
    required this.isShopping,
    required this.productCount,
    required this.checkedCount,
    required this.previousShoppingAmountSpent,
    required this.onBackPressed,
    required this.onHistoryPressed,
    required this.onBackToPreparationPressed,
    super.key,
  });

  final StoreModel store;

  /// Whether the list is being shopped, as opposed to prepared.
  final bool isShopping;

  /// Number of different products on this store's list.
  final int productCount;

  /// Number of products on the list that are already in the basket.
  final int checkedCount;

  /// Spent at this store the last time, or null if nothing was bought yet.
  final double? previousShoppingAmountSpent;
  final VoidCallback onBackPressed;
  final VoidCallback onHistoryPressed;
  final VoidCallback onBackToPreparationPressed;

  static const Duration _phaseSwitchDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularButton(icon: Assets.icon.chevronLeft.svg(width: 20, height: 20), onPressed: onBackPressed),
              if (isShopping)
                SecondaryButton(
                  text: LocaleKeys.shoppingInProgress_backToPreparation.tr(),
                  onPressed: onBackToPreparationPressed,
                )
              else
                SecondaryButton(text: LocaleKeys.home_history.tr(), onPressed: onHistoryPressed),
            ],
          ),
          const SizedBox(height: 14),
          _StoreName(store: store, previousShoppingAmountSpent: previousShoppingAmountSpent),
          const SizedBox(height: 14),
          AnimatedSize(
            duration: _phaseSwitchDuration,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: _phaseSwitchDuration,
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.topLeft,
                children: [...previousChildren, ?currentChild],
              ),
              child: isShopping
                  ? _ShoppingProgress(checkedCount: checkedCount, productCount: productCount)
                  : _StatusSection(productCount: productCount),
            ),
          ),
        ],
      ),
    );
  }
}

/// The store's name, with what was spent there the last time on the right.
class _StoreName extends StatelessWidget {
  const new({required this.store, required this.previousShoppingAmountSpent});

  final StoreModel store;
  final double? previousShoppingAmountSpent;

  @override
  Widget build(BuildContext context) {
    final textStyles = CustomTextStyles.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(store.storeName, style: textStyles.semiBold30, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Opacity(
              opacity: 0.85,
              child: Text(LocaleKeys.history_lastTime.tr(), style: textStyles.regular12),
            ),
            const SizedBox(height: 4),
            AmountText(
              amount: previousShoppingAmountSpent,
              currency: store.displayCurrency,
              amountStyle: textStyles.semiBold20,
              currencyStyle: textStyles.medium12.copyWith(fontSize: 11, letterSpacing: 0),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusSection extends StatelessWidget {
  const new({required this.productCount});

  final int productCount;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.92,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: CustomColors.of(context).badgeBackground,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              LocaleKeys.shoppingPreparation_preparation.tr().toUpperCase(),
              style: CustomTextStyles.of(context).semiBold11.copyWith(letterSpacing: 0.8),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              productCount > 0
                  ? LocaleKeys.shoppingPreparation_productsInList.plural(productCount)
                  : LocaleKeys.shoppingPreparation_prepareListBeforeLeaving.tr(),
              style: CustomTextStyles.of(context).regular13,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingProgress extends StatelessWidget {
  const new({required this.checkedCount, required this.productCount});

  final int checkedCount;
  final int productCount;

  static const double _barHeight = 6;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: colors.progress, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 8),
            Text(
              LocaleKeys.shoppingInProgress_shopping.tr().toUpperCase(),
              style: textStyles.semiBold11.copyWith(letterSpacing: 0.8),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(_barHeight / 2),
          child: SizedBox(
            height: _barHeight,
            width: double.infinity,
            child: ColoredBox(
              color: colors.primaryText.withValues(alpha: 0.2),
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: productCount == 0 ? 0 : checkedCount / productCount),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                builder: (context, progress, child) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: child,
                ),
                child: ColoredBox(color: colors.progress),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.9,
          child: Text(
            LocaleKeys.shoppingInProgress_checkedOfTotal.tr(
              namedArgs: {'checked': '$checkedCount', 'total': '$productCount'},
            ),
            style: textStyles.regular12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
