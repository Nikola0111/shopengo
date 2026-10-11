import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/product/presentation/amount_type_extension.dart';
import 'package:shopengo/feature/shopping_preparation/domain/model/shopping_list_item_model.dart';

class ShoppingListItem extends StatelessWidget {
  const new({required this.item, required this.onIncreasePressed, required this.onDecreasePressed, super.key});

  final ShoppingListItemModel item;
  final VoidCallback onIncreasePressed;
  final VoidCallback onDecreasePressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return ColoredBox(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 11, 10, 11),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.product.name,
                style: CustomTextStyles.of(context).medium16.copyWith(color: colors.dark),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            _QuantityStepper(
              label: '${item.quantity} ${item.product.amountType.shortLabel}',
              onIncreasePressed: onIncreasePressed,
              onDecreasePressed: onDecreasePressed,
            ),
          ],
        ),
      ),
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
