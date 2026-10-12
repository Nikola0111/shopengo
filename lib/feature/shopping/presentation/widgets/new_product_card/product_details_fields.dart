import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/amount_type_picker.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/category_selection_chip.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_category_chip.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_product_section_label.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// Unit and category pickers shared by creating and editing a product.
class ProductDetailsFields extends StatelessWidget {
  const new({
    required this.amountType,
    required this.onAmountTypeSelected,
    required this.categories,
    required this.categoryId,
    required this.onCategorySelected,
    required this.onNewCategoryPressed,
    this.onEditCategoriesPressed,
    super.key,
  });

  final AmountType amountType;
  final ValueChanged<AmountType> onAmountTypeSelected;
  final List<CategoryModel> categories;
  final int categoryId;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback onNewCategoryPressed;

  /// Shows an edit link next to the category label when set.
  final VoidCallback? onEditCategoriesPressed;

  @override
  Widget build(BuildContext context) {
    final onEditCategoriesPressed = this.onEditCategoriesPressed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NewProductSectionLabel(text: LocaleKeys.addProductSheet_unit.tr()),
        const SizedBox(height: 8),
        AmountTypePicker(selectedAmountType: amountType, onSelected: onAmountTypeSelected),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: NewProductSectionLabel(text: LocaleKeys.addProductSheet_category.tr())),
            if (onEditCategoriesPressed != null)
              GestureDetector(
                onTap: onEditCategoriesPressed,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  LocaleKeys.editProductSheet_editCategories.tr(),
                  style: CustomTextStyles.of(context).semiBold14.copyWith(color: CustomColors.of(context).accentText),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final category in categories)
              CategorySelectionChip(
                category: category,
                isSelected: category.id == categoryId,
                onPressed: () => onCategorySelected(category.id),
              ),
            NewCategoryChip(onPressed: onNewCategoryPressed),
          ],
        ),
      ],
    );
  }
}
