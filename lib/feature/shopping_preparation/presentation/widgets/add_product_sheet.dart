import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/grouped_card.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/presentation/amount_type_extension.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_bloc.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/categories_sheet.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class AddProductSheet extends StatefulWidget {
  const new({required this.store, super.key});

  final StoreModel store;

  static Future<void> show(BuildContext context, {required StoreModel store}) async {
    final bloc = context.read<ShoppingPreparationBloc>();
    await AppBottomSheet.show<void>(
      context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: AddProductSheet(store: store),
      ),
    );
    bloc.add(ShoppingPreparationQueryProductsEvent(query: ''));
  }

  @override
  State<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmit(String productName) {
    context.read<ShoppingPreparationBloc>().add(ShoppingPreparationSubmitProductEvent(productName: productName));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // `useSafeArea` already keeps the sheet below the status bar, so size it from the space it's given.
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight - AppBottomSheet.fullHeightTopGap,
        child: Column(
          children: [
            const SheetDragHandle(),
            SheetHeader(
              title: LocaleKeys.addProductSheet_addTo.tr(namedArgs: {'storeName': widget.store.storeName}),
              buttonText: LocaleKeys.addProductSheet_done.tr(),
              onButtonPressed: () => context.pop(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: _ProductNameField(
                controller: _controller,
                onChanged: (value) =>
                    context.read<ShoppingPreparationBloc>().add(ShoppingPreparationQueryProductsEvent(query: value)),
                onSubmitted: _onSubmit,
              ),
            ),
            Expanded(
              child: BlocBuilder<ShoppingPreparationBloc, ShoppingPreparationState>(
                builder: (context, state) {
                  final products = state.filteredProducts;
                  return ListView(
                    padding: EdgeInsets.fromLTRB(20, 4, 20, 30 + bottomInset),
                    children: [
                      if (state.isNewProductQuery) ...[
                        GroupedCard(
                          children: [
                            _ProductRow(
                              name: state.query.trim(),
                              subtitle:
                                  '${AmountType.piece.shortLabel} · ${LocaleKeys.addProductSheet_newProduct.tr()}',
                              onAddPressed: () => _onSubmit(state.query),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (products.isNotEmpty) ...[
                        const _SectionLabel(),
                        const SizedBox(height: 8),
                        GroupedCard(
                          children: [
                            for (final product in products)
                              _ProductRow(
                                name: product.name,
                                subtitle: product.amountType.shortLabel,
                                quantityInList: state.cartQuantities[product.id],
                                onAddPressed: () => context.read<ShoppingPreparationBloc>().add(
                                  ShoppingPreparationAddProductEvent(productId: product.id),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      Center(
                        child: TextButton(
                          onPressed: () => CategoriesSheet.show(context),
                          style: TextButton.styleFrom(foregroundColor: CustomColors.of(context).accentText),
                          child: Text(
                            LocaleKeys.addProductSheet_manageCategories.tr(),
                            style: CustomTextStyles.of(context).semiBold16
                                .copyWith(color: CustomColors.of(context).accentText),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductNameField extends StatelessWidget {
  const new({required this.controller, required this.onChanged, required this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).regular17;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
      ),
      child: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        style: textStyle.copyWith(color: colors.dark),
        cursorColor: colors.primary,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        // Keeps the keyboard open so several products can be added in a row.
        onEditingComplete: () {},
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: LocaleKeys.addProductSheet_productNameHint.tr(),
          hintStyle: textStyle.copyWith(color: colors.hintText),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 8),
        Text(
          LocaleKeys.addProductSheet_frequentlyBought.tr().toUpperCase(),
          style: CustomTextStyles.of(context).semiBold12.copyWith(color: colors.sectionLabel, letterSpacing: 1),
        ),
      ],
    );
  }
}

class _ProductRow extends StatelessWidget {
  const new({required this.name, required this.subtitle, required this.onAddPressed, this.quantityInList});

  final String name;
  final String subtitle;
  final int? quantityInList;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    final quantity = quantityInList;
    return ColoredBox(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textStyles.medium15.copyWith(color: colors.dark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: textStyles.regular12.copyWith(color: colors.mutedText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (quantity != null) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(color: colors.highlight, borderRadius: BorderRadius.circular(999)),
                child: Text(
                  LocaleKeys.addProductSheet_inList.tr(namedArgs: {'quantity': '$quantity'}),
                  style: textStyles.semiBold12.copyWith(color: colors.accentText),
                ),
              ),
            ],
            const SizedBox(width: 12),
            Material(
              color: colors.background,
              shape: CircleBorder(side: BorderSide(color: colors.outline)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onAddPressed,
                splashColor: colors.highlight,
                highlightColor: colors.surface,
                child: SizedBox.square(
                  dimension: 30,
                  child: Center(
                    child: Text('+', style: textStyles.regular18.copyWith(color: colors.primary, height: 1)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
