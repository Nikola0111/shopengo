import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/utils/date_formatter.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({required this.store, super.key});
  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            CustomColors.of(context).storeCardGradientStart,
            CustomColors.of(context).storeCardGradientEnd,
          ],
        ),
      ),
      child: Column(
        children: [
          _InfoSection(store: store),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(store.storeName, style: CustomTextStyles.of(context).medium20),
            Text(totalAmountSpentText, style: CustomTextStyles.of(context).medium16),
          ],
        ),
        if (store.previousShoppingDate != null && store.previousShoppingArticlesBought != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.home_numOfArticles,
                style: CustomTextStyles.of(context).regular14,
              ).tr(
                namedArgs: {'articlesAmount': store.previousShoppingArticlesBought!.toString()},
              ),
              Text(
                DateFormatter.formatForStoreCard(store.previousShoppingDate!),
                style: CustomTextStyles.of(context).regular14,
              ),
            ],
          ),
        ],
      ],
    );
  }

  String get totalAmountSpentText {
    if (store.totalAmountSpentAtStore != null) return store.totalAmountSpentAtStore!.toString();
    return LocaleKeys.home_noMoneySpend.tr();
  }
}
