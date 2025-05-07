import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_item_model.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_list_model.dart';

part '../../../../generated/feature/shopping_list/domain/cubit/shopping_list_state.freezed.dart';

@freezed
sealed class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.loading({
    required StoreModel selectedStore,
    required List<ShoppingItemModel> shoppingItems,
    required ShoppingListModel shoppingList,
  }) = ShoppingListLoadingState;
  const factory ShoppingListState.ready({
    required StoreModel selectedStore,
    required List<ShoppingItemModel> shoppingItems,
    required ShoppingListModel shoppingList,
  }) = ShoppingListReadyState;
}
