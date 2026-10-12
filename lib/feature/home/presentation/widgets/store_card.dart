import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/core/presentation/utils/date_formatter.dart';
import 'package:basketwise/core/presentation/widgets/amount_text.dart';
import 'package:basketwise/core/presentation/widgets/rounded_button.dart';
import 'package:basketwise/core/presentation/widgets/secondary_button.dart';
import 'package:basketwise/feature/home/domain/model/store_model.dart';
import 'package:basketwise/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const new({
    required this.store,
    required this.onOpenStore,
    required this.onHistoryPressed,
    super.key,
  });

  final StoreModel store;
  final VoidCallback onOpenStore;
  final VoidCallback onHistoryPressed;

  static const double _decorationCircleSize = 200;

  @override
  Widget build(BuildContext context) {
    final borderColor = CustomColors.of(context).primaryText.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onOpenStore,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.of(context).storeCardGradientStart,
              CustomColors.of(context).storeCardGradientEnd,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -_decorationCircleSize / 3,
              right: -_decorationCircleSize / 3,
              child: Container(
                width: _decorationCircleSize,
                height: _decorationCircleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: CustomColors.of(context).primaryText.withValues(alpha: 0.15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          store.storeName,
                          style: CustomTextStyles.of(context).bold20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AmountText(
                        amount: store.previousShoppingAmountSpent,
                        currency: store.displayCurrency,
                        amountStyle: CustomTextStyles.of(context).semiBold16.copyWith(fontSize: 17),
                        currencyStyle: CustomTextStyles.of(context).medium12.copyWith(fontSize: 10, letterSpacing: 0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _PreviousShopping(store: store),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      RoundedButton(
                        icon: Icons.shopping_cart_outlined,
                        backgroundColor: CustomColors.of(context).background,
                        iconColor: CustomColors.of(context).primary,
                        size: 36,
                        onPressed: onOpenStore,
                      ),
                      const SizedBox(width: 10),
                      SecondaryButton(text: LocaleKeys.home_history.tr(), onPressed: onHistoryPressed),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// How many products were bought the last time, and when.
class _PreviousShopping extends StatelessWidget {
  const new({required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    final textStyle = CustomTextStyles.of(context).regular14;
    final date = store.previousShoppingDate;
    return Row(
      children: [
        Expanded(
          child: Text(
            LocaleKeys.home_productsBought.tr(namedArgs: {'count': '${store.previousShoppingArticlesBought ?? 0}'}),
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          date == null ? LocaleKeys.home_noShoppings.tr() : DateFormatter.formatForHistory(date),
          style: textStyle,
        ),
      ],
    );
  }
}
