import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/shopping_list/domain/cubit/shopping_list_event.freezed.dart';

@freezed
class ShoppingListEvent with _$ShoppingListEvent {
  const factory ShoppingListEvent.loadData() = ShoppingListLoadDataEvent;
  const factory ShoppingListEvent.createAndAddGrocery({required String groceryName}) = ShoppingListCreateAddGrocery;
  const factory ShoppingListEvent.queryListAndItems({required String query}) = ShoppingListQueryEvent;
}
