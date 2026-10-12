import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/feature/product/presentation/amount_type_extension.dart';
import 'package:basketwise/feature/shopping/domain/model/shopping_list_item_model.dart';
import 'package:flutter/material.dart';

/// A product on the list. Its quantity can be changed while preparing, and it can be checked off while shopping.
class ShoppingListItem extends StatelessWidget {
  const new({
    required this.item,
    required this.isShopping,
    required this.onIncreasePressed,
    required this.onDecreasePressed,
    required this.onCheckPressed,
    super.key,
  });

  final ShoppingListItemModel item;
  final bool isShopping;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;
  final VoidCallback onCheckPressed;

  static const Duration _phaseSwitchDuration = Duration(milliseconds: 250);

  /// Height of the quantity stepper, kept while shopping so rows don't change height.
  static const double _trailingHeight = 34;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    final isChecked = isShopping && item.isChecked;
    final quantityLabel = '${item.quantity} ${item.product.amountType.shortLabel}';
    return Material(
      color: colors.background,
      child: InkWell(
        onTap: isShopping ? onCheckPressed : null,
        splashColor: colors.highlight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 11, 10, 11),
          child: Row(
            children: [
              AnimatedSize(
                duration: _phaseSwitchDuration,
                child: isShopping
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _CheckCircle(isChecked: isChecked),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: Text(
                  item.product.name,
                  style: textStyles.medium16.copyWith(
                    color: isChecked ? colors.mutedText : colors.dark,
                    decoration: isChecked ? TextDecoration.lineThrough : null,
                    decorationColor: colors.mutedText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: _trailingHeight,
                child: AnimatedSwitcher(
                  duration: _phaseSwitchDuration,
                  child: isShopping
                      ? Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Center(
                            widthFactor: 1,
                            child: Text(
                              quantityLabel,
                              style: textStyles.semiBold15.copyWith(
                                color: isChecked ? colors.mutedText : colors.quantityText,
                              ),
                            ),
                          ),
                        )
                      : _QuantityStepper(
                          label: quantityLabel,
                          onIncreasePressed: onIncreasePressed,
                          onDecreasePressed: onDecreasePressed,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const new({required this.isChecked});

  final bool isChecked;

  static const double _size = 26;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: isChecked ? colors.primary : colors.background,
        shape: BoxShape.circle,
        border: Border.all(color: isChecked ? colors.primary : colors.checkboxBorder, width: 2),
      ),
      child: isChecked ? Icon(Icons.check_rounded, size: 16, color: colors.primaryText) : null,
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const new({required this.label, required this.onIncreasePressed, required this.onDecreasePressed});

  final String label;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Material(
      color: colors.fill,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(symbol: '−', onPressed: onDecreasePressed),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 44),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: CustomTextStyles.of(context).semiBold14.copyWith(color: colors.dark),
            ),
          ),
          _StepperButton(symbol: '+', onPressed: onIncreasePressed),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const new({required this.symbol, required this.onPressed});

  final String symbol;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return InkWell(
      onTap: onPressed,
      splashColor: colors.highlight,
      child: SizedBox.square(
        dimension: 34,
        child: Center(
          child: Text(symbol, style: CustomTextStyles.of(context).regular18.copyWith(color: colors.primary, height: 1)),
        ),
      ),
    );
  }
}
