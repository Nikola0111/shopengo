import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/circular_button.dart';
import 'package:shopengo/core/presentation/widgets/secondary_button.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class StoreAppBar extends StatelessWidget {
  const new({required this.store, required this.onBackPressed, required this.onHistoryPressed, super.key});

  final StoreModel store;
  final VoidCallback onBackPressed;
  final VoidCallback onHistoryPressed;

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
              CircularButton(
                icon: Assets.icon.chevronLeft.svg(width: 20, height: 20),
                onPressed: onBackPressed,
              ),
              SecondaryButton(text: LocaleKeys.home_history.tr(), onPressed: onHistoryPressed),
            ],
          ),
          const SizedBox(height: 14),
          _StoreName(store: store),
          const SizedBox(height: 14),
          const _StatusSection(),
        ],
      ),
    );
  }
}

class _StoreName extends StatelessWidget {
  const new({required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Text(
      store.storeName,
      style: CustomTextStyles.of(context).semiBold30,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _StatusSection extends StatelessWidget {
  const new();

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
              LocaleKeys.store_preparation.tr().toUpperCase(),
              style: CustomTextStyles.of(context).semiBold11.copyWith(letterSpacing: 0.8),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              LocaleKeys.store_prepareListBeforeLeaving.tr(),
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
