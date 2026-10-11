import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';
import 'package:shopengo/feature/shopping_preparation/domain/model/shopping_list_item_model.dart';

part '../../../../generated/feature/shopping_preparation/domain/cubit/shopping_preparation_state.freezed.dart';

@freezed
class ShoppingPreparationState with _$ShoppingPreparationState {
  const new({this.products = const [], this.categories = const [], this.query = '', this.cartQuantities = const {}});

  final List<ProductModel> products;

  final List<CategoryModel> categories;

  final String query;

  /// Quantity of each product in this store's cart, keyed by product id.
  final Map<int, int> cartQuantities;

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
          ShoppingListItemModel(product: product, quantity: quantity),
    ];
    return categories
        .map(
          (category) => (category: category, items: items.where((e) => e.product.categoryId == category.id).toList()),
        )
        .where((section) => section.items.isNotEmpty)
        .toList();
  }
}
