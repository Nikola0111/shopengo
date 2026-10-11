import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';
import 'package:shopengo/feature/shopping/domain/model/shopping_list_item_model.dart';

part '../../../../generated/feature/shopping/domain/cubit/shopping_state.freezed.dart';

@freezed
class ShoppingState with _$ShoppingState {
  const new({
    this.products = const [],
    this.categories = const [],
    this.query = '',
    this.cartQuantities = const {},
    this.checkedProductIds = const {},
    this.isShopping = false,
  });

  final List<ProductModel> products;

  final List<CategoryModel> categories;

  final String query;

  /// Quantity of each product in this store's cart, keyed by product id.
  final Map<int, int> cartQuantities;

  /// Products in this store's cart that are already in the basket.
  final Set<int> checkedProductIds;

  /// Whether the list is being shopped, as opposed to prepared.
  final bool isShopping;

  List<ProductModel> get filteredProducts {
    final normalizedQuery = query.trim().toUpperCase();
    return products.where((e) => e.name.toUpperCase().contains(normalizedQuery)).toList();
  }

  /// Whether the query names a product that isn't saved yet.
  bool get isNewProductQuery {
    final normalizedQuery = query.trim().toUpperCase();
    return normalizedQuery.isNotEmpty && products.every((e) => e.name.toUpperCase() != normalizedQuery);
  }

  /// Products in this store's cart, grouped by category in category order. Empty categories are left out.
  List<({CategoryModel category, List<ShoppingListItemModel> items})> get shoppingList {
    final items = [
      for (final product in products)
        if (cartQuantities[product.id] case final quantity?)
          ShoppingListItemModel(
            product: product,
            quantity: quantity,
            isChecked: checkedProductIds.contains(product.id),
          ),
    ];
    return categories
        .map(
          (category) => (category: category, items: items.where((e) => e.product.categoryId == category.id).toList()),
        )
        .where((section) => section.items.isNotEmpty)
        .toList();
  }
}
