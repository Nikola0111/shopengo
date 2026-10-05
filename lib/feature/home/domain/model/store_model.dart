import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/home/domain/model/store_model.freezed.dart';

@freezed
class StoreModel with _$StoreModel {
  new({
    required this.id,
    required this.storeName,
    this.currency,
    this.totalAmountSpentAtStore,
    this.previousShoppingArticlesBought,
    this.previousShoppingDate,
  });

  final int id;

  final String storeName;

  final String? currency;

  final DateTime? previousShoppingDate;

  final double? totalAmountSpentAtStore;

  final int? previousShoppingArticlesBought;
}
