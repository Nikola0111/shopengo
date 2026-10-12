import 'package:basketwise/feature/history/domain/model/shopping_history_item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/history/domain/model/shopping_history_model.freezed.dart';

/// A finished shopping at a store and the products bought in it.
@freezed
class ShoppingHistoryModel with _$ShoppingHistoryModel {
  new({required this.id, required this.date, this.amountSpent, this.items = const []});

  final int id;

  final DateTime date;

  final double? amountSpent;

  final List<ShoppingHistoryItemModel> items;
}
