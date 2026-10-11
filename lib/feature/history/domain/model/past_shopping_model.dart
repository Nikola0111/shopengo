import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_item_model.dart';

part '../../../../generated/feature/history/domain/model/past_shopping_model.freezed.dart';

/// A finished shopping at a store and the products bought in it.
@freezed
class PastShoppingModel with _$PastShoppingModel {
  new({required this.id, required this.date, this.amountSpent, this.items = const []});

  final int id;

  final DateTime date;

  final double? amountSpent;

  final List<PastShoppingItemModel> items;
}
