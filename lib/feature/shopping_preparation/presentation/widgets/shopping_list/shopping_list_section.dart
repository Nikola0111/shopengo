import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/widgets/grouped_card.dart';
import 'package:shopengo/core/presentation/widgets/section_label.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/category/presentation/category_model_extension.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_list/shopping_list_item.dart';

/// A category's products on the shopping list.
class ShoppingListSection extends StatelessWidget {
  const new({
    required this.category,
    required this.products,
    required this.quantities,
    required this.onIncreasePressed,
    required this.onDecreasePressed,
    super.key,
  });

  final CategoryModel category;
  final List<ProductModel> products;

  /// Quantity of each product on the list, keyed by product id.
  final Map<int, int> quantities;
  final ValueChanged<ProductModel> onIncreasePressed;
  final ValueChanged<ProductModel> onDecreasePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(title: category.displayTitle, dotColor: category.color),
        const SizedBox(height: 10),
        GroupedCard(
          children: [
            for (final product in products)
              ShoppingListItem(
                product: product,
                quantity: quantities[product.id] ?? 0,
                onIncreasePressed: () => onIncreasePressed(product),
                onDecreasePressed: () => onDecreasePressed(product),
              ),
          ],
        ),
      ],
    );
  }
}
