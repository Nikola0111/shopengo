import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_item_model.dart';

part '../../../../generated/feature/shopping_list/domain/model/shopping_list_model.freezed.dart';

@freezed
class ShoppingListModel with _$ShoppingListModel {
  ShoppingListModel({
    required this.storeID,
    required this.shoppingItems,
  });

  @override
  final int storeID;

  @override
  final List<ShoppingItemModel> shoppingItems;
}
