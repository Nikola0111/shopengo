import 'package:basketwise/feature/history/domain/model/shopping_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/history/domain/cubit/history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const new({this.shoppingHistory = const [], this.isLoading = true});

  /// The store's finished shoppings, newest first.
  final List<ShoppingHistoryModel> shoppingHistory;

  final bool isLoading;

  /// Sum of all amounts spent. Shoppings without an amount don't count.
  double get totalSpent => shoppingHistory.fold(0, (total, shopping) => total + (shopping.amountSpent ?? 0));
}
