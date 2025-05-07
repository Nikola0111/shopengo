import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/shopping_list/domain/cubit/shopping_list_event.freezed.dart';

@freezed
class ShoppingListEvent with _$ShoppingListEvent {
  const factory ShoppingListEvent.loadData() = LoadShoppingData;
  const factory ShoppingListEvent.createAndAddShoppingItem({required String groceryName}) = CreateAndAddShoppingItem;
  const factory ShoppingListEvent.addToShoppingList({required int id}) = AddToShoppingList;
  const factory ShoppingListEvent.removeFromShoppingList({required int id}) = RemoveFromShoppingList;
  const factory ShoppingListEvent.queryListAndItems({required String query}) = QueryShoppingListAndItems;
}
