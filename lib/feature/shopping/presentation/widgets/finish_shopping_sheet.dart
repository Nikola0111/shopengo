import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/dark_button.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// How shopping was finished. `amountSpent` is null when nothing was checked.
typedef FinishedShopping = ({double? amountSpent});

/// Confirms finishing shopping, asking for the amount on the receipt when there are checked products to save.
class FinishShoppingSheet extends StatefulWidget {
  const new({required this.checkedCount, required this.productCount, required this.currency, super.key});

  final int checkedCount;
  final int productCount;
  final String currency;

  /// Returns how shopping was finished, or null if the sheet was dismissed.
  static Future<FinishedShopping?> show(
    BuildContext context, {
    required int checkedCount,
    required int productCount,
    required String currency,
  }) {
    return AppBottomSheet.show<FinishedShopping>(
      context,
      builder: (context) =>
          FinishShoppingSheet(checkedCount: checkedCount, productCount: productCount, currency: currency),
    );
  }

  @override
  State<FinishShoppingSheet> createState() => _FinishShoppingSheetState();
}

class _FinishShoppingSheetState extends State<FinishShoppingSheet> {
  final _controller = TextEditingController();

  bool get _hasCheckedProducts => widget.checkedCount > 0;

  /// Entered amount, or null while it isn't a positive number.
  double? get _amount => switch (double.tryParse(_controller.text.replaceAll(',', '.'))) {
    final amount? when amount > 0 => amount,
    _ => null,
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFinish() {
    if (!_hasCheckedProducts) {
      context.pop<FinishedShopping>((amountSpent: null));
      return;
    }

    if (_amount case final amount?) {
      context.pop<FinishedShopping>((amountSpent: amount));
    }
  }

  String get _description {
    if (!_hasCheckedProducts) {
      return LocaleKeys.finishShoppingSheet_nothingChecked.tr();
    }

    final saved = LocaleKeys.finishShoppingSheet_checkedSaved.plural(widget.checkedCount);
    return widget.checkedCount < widget.productCount
        ? '$saved ${LocaleKeys.finishShoppingSheet_uncheckedStay.tr()}'
        : saved;
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final bottomPadding = MediaQuery.viewInsetsOf(context).bottom + MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetDragHandle(),
          SheetHeader(
            title: LocaleKeys.finishShoppingSheet_title.tr(),
            buttonText: LocaleKeys.finishShoppingSheet_done.tr(),
            onButtonPressed: () => context.pop(),
          ),
          Flexible(
            // Scrolls when the keyboard leaves too little room on small phones.
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _description,
                    style: CustomTextStyles.of(context).regular14.copyWith(color: colors.bodyText, height: 1.45),
                  ),
                  const SizedBox(height: 14),
                  if (_hasCheckedProducts) ...[
                    _AmountField(
                      controller: _controller,
                      currency: widget.currency,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _onFinish(),
                    ),
                    const SizedBox(height: 14),
                  ],
                  DarkButton(
                    text: _hasCheckedProducts
                        ? LocaleKeys.finishShoppingSheet_saveToHistory.tr()
                        : LocaleKeys.finishShoppingSheet_finishWithoutSaving.tr(),
                    height: 50,
                    textStyle: CustomTextStyles.of(context).semiBold15,
                    onPressed: !_hasCheckedProducts || _amount != null ? _onFinish : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  const new({required this.controller, required this.currency, required this.onChanged, required this.onSubmitted});

  final TextEditingController controller;
  final String currency;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  /// Whole amount with up to two decimals, separated by a dot or a comma.
  static final _amountPattern = RegExp(r'^\d{0,9}([.,]\d{0,2})?$');

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) => _amountPattern.hasMatch(newValue.text) ? newValue : oldValue,
                ),
              ],
              style: textStyles.semiBold20.copyWith(color: colors.dark),
              cursorColor: colors.primary,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: LocaleKeys.finishShoppingSheet_amountHint.tr(),
                hintStyle: textStyles.semiBold20.copyWith(color: colors.hintText),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(currency, style: textStyles.semiBold14.copyWith(color: colors.mutedText)),
        ],
      ),
    );
  }
}
