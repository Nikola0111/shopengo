import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

part '../../../../generated/feature/history/domain/model/shopping_history_item_model.freezed.dart';

/// A product as it was bought, kept in the shopping history.
@freezed
class ShoppingHistoryItemModel with _$ShoppingHistoryItemModel {
  new({required this.productName, required this.amountType, required this.quantity});

  final String productName;

  final AmountType amountType;

  final int quantity;
}
