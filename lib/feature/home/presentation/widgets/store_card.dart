import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/rounded_button.dart';
import 'package:shopengo/core/presentation/widgets/secondary_button.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class StoreCard extends StatelessWidget {
  const new({
    required this.store,
    required this.onTap,
    required this.onCartPressed,
    required this.onHistoryPressed,
    super.key,
  });

  final StoreModel store;
  final VoidCallback onTap;
  final VoidCallback onCartPressed;
  final VoidCallback onHistoryPressed;

  static const double _decorationCircleSize = 200;

  @override
  Widget build(BuildContext context) {
    final borderColor = CustomColors.of(context).primaryText.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
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
                  Text(store.storeName, style: CustomTextStyles.of(context).bold20),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(LocaleKeys.home_emptyList, style: CustomTextStyles.of(context).medium16).tr(),
                      ),
                      const SizedBox(width: 8),
                      Text(LocaleKeys.home_startFirstShopping, style: CustomTextStyles.of(context).regular14).tr(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      RoundedButton(
                        icon: Icons.shopping_cart_outlined,
                        backgroundColor: CustomColors.of(context).background,
                        iconColor: CustomColors.of(context).primary,
                        size: 36,
                        onPressed: onCartPressed,
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
