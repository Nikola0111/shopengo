import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_bloc.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_event.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_state.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/categories_sheet.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_category_chip.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/product_details_fields.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/product_name_field.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class EditProductSheet extends StatefulWidget {
  const new({required this.product, super.key});

  final ProductModel product;

  static Future<void> show(BuildContext context, {required ProductModel product}) {
    final bloc = context.read<ShoppingBloc>();
    return AppBottomSheet.show<void>(
      context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: EditProductSheet(product: product),
      ),
    );
  }

  @override
  State<EditProductSheet> createState() => _EditProductSheetState();
}

class _EditProductSheetState extends State<EditProductSheet> {
  late final _controller = TextEditingController(text: widget.product.name);
  late AmountType _amountType = widget.product.amountType;
  late int _categoryId = widget.product.categoryId;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSave() {
    final bloc = context.read<ShoppingBloc>();
    if (!bloc.state.isAvailableProductName(_controller.text, productId: widget.product.id)) {
      return;
    }
    bloc.add(
      ShoppingUpdateProductEvent(
        product: widget.product.copyWith(
          name: _controller.text,
          amountType: _amountType,
          categoryId: bloc.state.existingCategoryId(_categoryId),
        ),
      ),
    );
    context.pop();
  }

  void _onDelete() {
    context.read<ShoppingBloc>().add(ShoppingDeleteProductEvent(productId: widget.product.id));
    context.pop();
  }

  Future<void> _onNewCategoryPressed() async {
    final categoryId = await NewCategoryChip.createCategory(context);
    if (categoryId != null && mounted) {
      setState(() => _categoryId = categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.viewInsetsOf(context).bottom + MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetDragHandle(),
          SheetHeader(
            title: LocaleKeys.editProductSheet_title.tr(),
            buttonText: LocaleKeys.editProductSheet_back.tr(),
            onButtonPressed: () => context.pop(),
          ),
          Flexible(
            // Scrolls when the keyboard leaves too little room on small phones.
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: BlocBuilder<ShoppingBloc, ShoppingState>(
                buildWhen: (previous, current) =>
                    previous.categories != current.categories || previous.products != current.products,
                builder: (context, state) => Column(
                  children: [
                    ProductNameField(
                      controller: _controller,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _onSave(),
                    ),
                    const SizedBox(height: 22),
                    ProductDetailsFields(
                      amountType: _amountType,
                      onAmountTypeSelected: (amountType) => setState(() => _amountType = amountType),
                      categories: state.categories,
                      categoryId: state.existingCategoryId(_categoryId),
                      onCategorySelected: (categoryId) => setState(() => _categoryId = categoryId),
                      onNewCategoryPressed: _onNewCategoryPressed,
                      onEditCategoriesPressed: () => CategoriesSheet.show(context),
                    ),
                    const SizedBox(height: 24),
                    _SaveButton(
                      onPressed: state.isAvailableProductName(_controller.text, productId: widget.product.id)
                          ? _onSave
                          : null,
                    ),
                    const SizedBox(height: 10),
                    _DeleteButton(onPressed: _onDelete),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.primary,
          disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
          foregroundColor: colors.primaryText,
          disabledForegroundColor: colors.primaryText,
          shape: const StadiumBorder(),
        ),
        child: Text(LocaleKeys.editProductSheet_save.tr(), style: CustomTextStyles.of(context).semiBold16),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.danger,
          shape: StadiumBorder(side: BorderSide(color: colors.danger.withValues(alpha: 0.3))),
        ),
        child: Text(
          LocaleKeys.editProductSheet_delete.tr(),
          style: CustomTextStyles.of(context).semiBold16.copyWith(color: colors.danger),
        ),
      ),
    );
  }
}
