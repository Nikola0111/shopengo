import 'package:basketwise/core/presentation/widgets/grouped_card.dart';
import 'package:basketwise/core/presentation/widgets/section_label.dart';
import 'package:basketwise/feature/category/domain/model/category_model.dart';
import 'package:basketwise/feature/category/presentation/category_model_extension.dart';
import 'package:basketwise/feature/product/domain/model/product_model.dart';
import 'package:basketwise/feature/shopping/domain/model/shopping_list_item_model.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/shopping_list/shopping_list_item.dart';
import 'package:flutter/material.dart';

/// A category's products on the shopping list.
class ShoppingListSection extends StatelessWidget {
  const new({
    required this.category,
    required this.items,
    required this.isShopping,
    required this.onIncreasePressed,
    required this.onDecreasePressed,
    required this.onCheckPressed,
    super.key,
  });

  final CategoryModel category;
  final List<ShoppingListItemModel> items;
  final bool isShopping;
  final ValueChanged<ProductModel> onIncreasePressed;
  final ValueChanged<ProductModel> onDecreasePressed;
  final ValueChanged<ProductModel> onCheckPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(title: category.displayTitle, dotColor: category.color),
        const SizedBox(height: 10),
        GroupedCard(
          children: [
            for (final item in items)
              ShoppingListItem(
                item: item,
                isShopping: isShopping,
                onIncreasePressed: () => onIncreasePressed(item.product),
                onDecreasePressed: () => onDecreasePressed(item.product),
                onCheckPressed: () => onCheckPressed(item.product),
              ),
          ],
        ),
      ],
    );
  }
}
