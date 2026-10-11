import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/amount_type_picker.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/category_selection_chip.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_category_chip.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_product_card_header.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_product_save_button.dart';
import 'package:shopengo/feature/shopping/presentation/widgets/new_product_card/new_product_section_label.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// Offers to create a product named [name], expanding to pick its unit and category before saving.
class NewProductCard extends StatelessWidget {
  const new({
    required this.name,
    required this.isExpanded,
    required this.onExpandToggled,
    required this.amountType,
    required this.onAmountTypeSelected,
    required this.categories,
    required this.categoryId,
    required this.onCategorySelected,
    required this.onNewCategoryPressed,
    required this.onSavePressed,
    super.key,
  });

  final String name;
  final bool isExpanded;
  final VoidCallback onExpandToggled;
  final AmountType amountType;
  final ValueChanged<AmountType> onAmountTypeSelected;
  final List<CategoryModel> categories;
  final int categoryId;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback onNewCategoryPressed;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        children: [
          NewProductCardHeader(name: name, isExpanded: isExpanded, onPressed: onExpandToggled),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colors.divider)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NewProductSectionLabel(text: LocaleKeys.addProductSheet_unit.tr()),
                          const SizedBox(height: 8),
                          AmountTypePicker(selectedAmountType: amountType, onSelected: onAmountTypeSelected),
                          const SizedBox(height: 14),
                          NewProductSectionLabel(text: LocaleKeys.addProductSheet_category.tr()),
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
                          const SizedBox(height: 14),
                          NewProductSaveButton(onPressed: onSavePressed),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
