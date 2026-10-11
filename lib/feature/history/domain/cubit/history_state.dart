import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_model.dart';

part '../../../../generated/feature/history/domain/cubit/history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const new({this.pastShoppings = const [], this.isLoading = true});

  /// The store's finished shoppings, newest first.
  final List<PastShoppingModel> pastShoppings;

  final bool isLoading;

  /// Sum of all amounts spent. Shoppings without an amount don't count.
  double get totalSpent => pastShoppings.fold(0, (total, shopping) => total + (shopping.amountSpent ?? 0));
}
