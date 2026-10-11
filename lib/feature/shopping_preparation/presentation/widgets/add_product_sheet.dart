import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/presentation/amount_type_extension.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_bloc.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class AddProductSheet extends StatefulWidget {
  const new({required this.store, super.key});

  final StoreModel store;

  static const double _radius = 28;
  static const double _topGap = 16;

  static Future<void> show(BuildContext context, {required StoreModel store}) async {
    final bloc = context.read<ShoppingPreparationBloc>();
    final colors = CustomColors.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: colors.surface,
      barrierColor: colors.scrim,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_radius))),
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
        height: constraints.maxHeight - AddProductSheet._topGap,
        child: Column(
          children: [
            const _DragHandle(),
            _Header(storeName: widget.store.storeName, onDonePressed: () => context.pop()),
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
                        _ProductGroup(
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
                        _ProductGroup(
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
                      ],
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

class _DragHandle extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(color: CustomColors.of(context).sheetHandle, borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const new({required this.storeName, required this.onDonePressed});

  final String storeName;
  final VoidCallback onDonePressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.addProductSheet_addTo.tr(namedArgs: {'storeName': storeName}),
              style: textStyles.semiBold20.copyWith(color: colors.dark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: colors.divider,
            shape: const StadiumBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onDonePressed,
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.addProductSheet_done.tr(),
                  style: textStyles.medium14.copyWith(color: colors.accentText),
                ),
              ),
            ),
          ),
        ],
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

/// White rows on a rounded card, separated by 1px dividers.
class _ProductGroup extends StatelessWidget {
  const new({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dividerColor = CustomColors.of(context).divider;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: dividerColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        children: [
          for (final (index, child) in children.indexed) ...[if (index > 0) const SizedBox(height: 1), child],
        ],
      ),
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
