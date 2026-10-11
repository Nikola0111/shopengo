import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/circular_button.dart';
import 'package:shopengo/feature/history/presentation/widgets/amount_text.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class HistoryHeader extends StatelessWidget {
  const new({
    required this.store,
    required this.shoppingCount,
    required this.totalSpent,
    required this.onBackPressed,
    super.key,
  });

  final StoreModel store;
  final int shoppingCount;
  final double totalSpent;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularButton(icon: Assets.icon.chevronLeft.svg(width: 20, height: 20), onPressed: onBackPressed),
          const SizedBox(height: 14),
          Opacity(
            opacity: 0.85,
            child: Text(
              LocaleKeys.history_label.tr(namedArgs: {'storeName': store.storeName}).toUpperCase(),
              style: textStyles.medium12.copyWith(letterSpacing: 1.2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Text(LocaleKeys.history_title.tr(), style: textStyles.semiBold30),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatTile(
                    label: LocaleKeys.history_shoppingCount.tr(),
                    value: Text('$shoppingCount', style: textStyles.semiBold20),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatTile(
                    label: LocaleKeys.history_totalSpent.tr(),
                    value: AmountText(
                      amount: totalSpent,
                      currency: store.displayCurrency,
                      amountStyle: textStyles.semiBold20,
                      currencyStyle: textStyles.medium12.copyWith(fontSize: 11, letterSpacing: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const new({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColors.of(context).background.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.85,
            child: Text(
              label,
              style: CustomTextStyles.of(context).regular12,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          value,
        ],
      ),
    );
  }
}
