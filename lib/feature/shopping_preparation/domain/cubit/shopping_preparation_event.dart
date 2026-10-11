import 'package:equatable/equatable.dart';

abstract class ShoppingPreparationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShoppingPreparationLoadProductsEvent extends ShoppingPreparationEvent;

class ShoppingPreparationQueryProductsEvent extends ShoppingPreparationEvent {
  new({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class ShoppingPreparationAddProductEvent extends ShoppingPreparationEvent {
  new({required this.productId});
  final int productId;

  @override
  List<Object?> get props => [productId];
}

/// Adds the product with [productName] to the list, creating it first if no saved product has that name.
class ShoppingPreparationSubmitProductEvent extends ShoppingPreparationEvent {
  new({required this.productName});
  final String productName;

  @override
  List<Object?> get props => [productName];
}
