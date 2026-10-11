import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

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
///
/// [amountType] and [categoryId] only apply when a new product is created.
class ShoppingPreparationSubmitProductEvent extends ShoppingPreparationEvent {
  new({required this.productName, this.amountType = AmountType.piece, this.categoryId});
  final String productName;
  final AmountType amountType;
  final int? categoryId;

  @override
  List<Object?> get props => [productName, amountType, categoryId];
}

class ShoppingPreparationCreateCategoryEvent extends ShoppingPreparationEvent {
  new({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  List<Object?> get props => [title, color];
}
