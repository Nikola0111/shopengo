import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

abstract class ShoppingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShoppingLoadProductsEvent extends ShoppingEvent;

class ShoppingQueryProductsEvent extends ShoppingEvent {
  new({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class ShoppingAddProductEvent extends ShoppingEvent {
  new({required this.productId});
  final int productId;

  @override
  List<Object?> get props => [productId];
}

/// Takes one of the product off the list, removing it once none are left.
class ShoppingDecreaseQuantityEvent extends ShoppingEvent {
  new({required this.productId});
  final int productId;

  @override
  List<Object?> get props => [productId];
}

/// Adds the product with [productName] to the list, creating it first if no saved product has that name.
///
/// [amountType] and [categoryId] only apply when a new product is created.
class ShoppingSubmitProductEvent extends ShoppingEvent {
  new({required this.productName, this.amountType = AmountType.piece, this.categoryId});
  final String productName;
  final AmountType amountType;
  final int? categoryId;

  @override
  List<Object?> get props => [productName, amountType, categoryId];
}

/// Saves the edited [product]'s name, unit and category.
class ShoppingUpdateProductEvent extends ShoppingEvent {
  new({required this.product});
  final ProductModel product;

  @override
  List<Object?> get props => [product];
}

/// Deletes the product, taking it off every store's list.
class ShoppingDeleteProductEvent extends ShoppingEvent {
  new({required this.productId});
  final int productId;

  @override
  List<Object?> get props => [productId];
}

class ShoppingCreateCategoryEvent extends ShoppingEvent {
  new({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  List<Object?> get props => [title, color];
}

class ShoppingUpdateCategoryEvent extends ShoppingEvent {
  new({required this.categoryId, required this.title, required this.color});
  final int categoryId;
  final String title;
  final Color color;

  @override
  List<Object?> get props => [categoryId, title, color];
}

/// Deletes the category, moving its products to the default one.
class ShoppingDeleteCategoryEvent extends ShoppingEvent {
  new({required this.categoryId});
  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}

class ShoppingStartShoppingEvent extends ShoppingEvent;

class ShoppingBackToPreparationEvent extends ShoppingEvent;

/// Puts the product in the basket, or takes it back out.
class ShoppingToggleCheckedEvent extends ShoppingEvent {
  new({required this.productId});
  final int productId;

  @override
  List<Object?> get props => [productId];
}

/// Ends shopping, saving checked products with [amountSpent] as this store's previous shopping.
class ShoppingFinishEvent extends ShoppingEvent {
  new({this.amountSpent});
  final double? amountSpent;

  @override
  List<Object?> get props => [amountSpent];
}
