import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

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
  List<(CategoryModel, List<ProductModel>)> get shoppingList {
    final cartProducts = products.where((e) => cartQuantities.containsKey(e.id)).toList();
    return categories
        .map((category) => (category, cartProducts.where((e) => e.categoryId == category.id).toList()))
        .where((e) => e.$2.isNotEmpty)
        .toList();
  }
}
