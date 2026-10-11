import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

part '../../../../generated/feature/shopping_preparation/domain/cubit/shopping_preparation_state.freezed.dart';

@freezed
class ShoppingPreparationState with _$ShoppingPreparationState {
  const new({this.products = const [], this.query = '', this.cartQuantities = const {}});

  final List<ProductModel> products;

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
}
