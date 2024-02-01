import 'package:equatable/equatable.dart';
import 'package:shopengo/core/models/shopping_list.dart';

abstract class ShoppingListsState extends Equatable {
  final List<ShoppingList> shoppingLists;
  final List<ShoppingList>? queriedList;
  final bool isPremiumUser;
  const ShoppingListsState({required this.shoppingLists, this.isPremiumUser = false, this.queriedList});

  @override
  List get props => [shoppingLists, queriedList, isPremiumUser];
}

class ViewingShoppingLists extends ShoppingListsState {
  const ViewingShoppingLists({required super.shoppingLists, super.isPremiumUser = false, super.queriedList});

  @override
  List get props => [shoppingLists, queriedList, isPremiumUser];
}
