import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/utils/date_formatter.dart';
import 'package:shopengo/core/presentation/widgets/amount_text.dart';
import 'package:shopengo/feature/history/domain/model/shopping_history_model.dart';
import 'package:shopengo/feature/product/presentation/amount_type_extension.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// A finished shopping. Tapping it shows or hides the products bought in it.
class ShoppingHistoryCard extends StatefulWidget {
  const new({required this.shopping, required this.currency, super.key});

  final ShoppingHistoryModel shopping;
  final String currency;

  @override
  State<ShoppingHistoryCard> createState() => _ShoppingHistoryCardState();
}

class _ShoppingHistoryCardState extends State<ShoppingHistoryCard> {
  static const Duration _expandDuration = Duration(milliseconds: 200);

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    final shopping = widget.shopping;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.divider),
      ),
      child: Material(
        color: colors.background,
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              splashColor: colors.highlight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormatter.formatForHistory(shopping.date),
                            style: textStyles.semiBold16.copyWith(color: colors.dark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            LocaleKeys.history_productCount.plural(shopping.items.length),
                            style: textStyles.regular13.copyWith(color: colors.mutedText),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    AmountText(
                      amount: shopping.amountSpent,
                      currency: widget.currency,
                      amountStyle: textStyles.semiBold16.copyWith(fontSize: 17, color: colors.dark),
                      currencyStyle: textStyles.medium12.copyWith(
                        fontSize: 10,
                        letterSpacing: 0,
                        color: colors.mutedText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: _expandDuration,
                      child: Icon(Icons.expand_more_rounded, size: 20, color: colors.hintText),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: _expandDuration,
              alignment: Alignment.topCenter,
              child: _isExpanded ? _ShoppingHistoryItems(shopping: shopping) : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingHistoryItems extends StatelessWidget {
  const new({required this.shopping});

  final ShoppingHistoryModel shopping;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Column(
      children: [
        Divider(height: 1, thickness: 1, color: colors.divider),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Column(
            children: [
              for (final item in shopping.items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.productName,
                          style: textStyles.medium15.copyWith(color: colors.dark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${item.quantity} ${item.amountType.shortLabel}',
                        style: textStyles.semiBold14.copyWith(color: colors.quantityText),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
