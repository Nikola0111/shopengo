import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

part '../../../../generated/feature/history/domain/model/past_shopping_item_model.freezed.dart';

/// A product as it was bought in a past shopping.
@freezed
class PastShoppingItemModel with _$PastShoppingItemModel {
  new({required this.productName, required this.amountType, required this.quantity});

  final String productName;

  final AmountType amountType;

  final int quantity;
}
