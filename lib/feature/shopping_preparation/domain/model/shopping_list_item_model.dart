import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

part '../../../../generated/feature/shopping_preparation/domain/model/shopping_list_item_model.freezed.dart';

/// A product on this store's shopping list and how many of it to buy.
@freezed
class ShoppingListItemModel with _$ShoppingListItemModel {
  new({required this.product, required this.quantity});

  final ProductModel product;

  final int quantity;
}
