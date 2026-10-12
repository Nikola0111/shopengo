import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:basketwise/feature/product/presentation/amount_type_extension.dart';
import 'package:flutter/material.dart';

class AmountTypePicker extends StatelessWidget {
  const new({required this.selectedAmountType, required this.onSelected, this.backgroundColor, super.key});

  final AmountType selectedAmountType;
  final ValueChanged<AmountType> onSelected;

  /// Defaults to the surface color, which stands out on a white card.
  final Color? backgroundColor;

  static const List<AmountType> _amountTypes = [
    AmountType.piece,
    AmountType.kilogram,
    AmountType.gram,
    AmountType.liter,
    AmountType.pack,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).medium14;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: backgroundColor ?? colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        spacing: 6,
        children: [
          for (final amountType in _amountTypes)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(amountType),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: amountType == selectedAmountType
                        ? colors.background
                        : colors.background.withValues(alpha: 0),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      if (amountType == selectedAmountType)
                        const BoxShadow(color: Color(0x26281E78), offset: Offset(0, 1), blurRadius: 1.5),
                    ],
                  ),
                  child: Text(
                    amountType.shortLabel,
                    style: textStyle.copyWith(
                      color: amountType == selectedAmountType ? colors.dark : colors.sectionLabel,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
