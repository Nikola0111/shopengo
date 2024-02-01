import 'package:equatable/equatable.dart';
import 'package:shopengo/core/models/shopping_list.dart';

abstract class ShoppingListsEvent extends Equatable {
  const ShoppingListsEvent();

  @override
  List get props => [];
}

class InitialEvent extends ShoppingListsEvent {
  const InitialEvent();

  @override
  List get props => [];
}

class CreatingNewList extends ShoppingListsEvent {
  @override
  List get props => [];
}

class QueryShoppingLists extends ShoppingListsEvent {
  final List<ShoppingList> queriedList;
  final String queryString;
  const QueryShoppingLists({required this.queryString, required this.queriedList});

  @override
  List get props => [queryString];
}

class OpenShoppingList extends ShoppingListsEvent {
  final String shoppingListID;
  const OpenShoppingList({required this.shoppingListID});

  @override
  List get props => [shoppingListID];
}

class StartShopping extends ShoppingListsEvent {
  final String shoppingListID;
  const StartShopping({required this.shoppingListID});

  @override
  List get props => [shoppingListID];
}

class ViewListHistory extends ShoppingListsEvent {
  final String shoppingListID;
  const ViewListHistory({required this.shoppingListID});

  @override
  List get props => [shoppingListID];
}
