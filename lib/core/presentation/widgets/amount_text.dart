import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/utils/amount_formatter.dart';

/// An amount followed by its currency in a smaller style, e.g. 3.000 RSD.
class AmountText extends StatelessWidget {
  const new({
    required this.amount,
    required this.currency,
    required this.amountStyle,
    required this.currencyStyle,
    super.key,
  });

  /// Shown as a dash when unknown.
  final double? amount;
  final String currency;
  final TextStyle amountStyle;
  final TextStyle currencyStyle;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${amount == null ? '—' : AmountFormatter.format(amount)} ', style: amountStyle),
          TextSpan(text: currency, style: currencyStyle),
        ],
      ),
      maxLines: 1,
    );
  }
}
