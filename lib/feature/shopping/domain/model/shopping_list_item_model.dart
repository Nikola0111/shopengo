import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

part '../../../../generated/feature/shopping/domain/model/shopping_list_item_model.freezed.dart';

/// A product on this store's shopping list, how many of it to buy and whether it's in the basket yet.
@freezed
class ShoppingListItemModel with _$ShoppingListItemModel {
  new({required this.product, required this.quantity, this.isChecked = false});

  final ProductModel product;

  final int quantity;

  final bool isChecked;
}
