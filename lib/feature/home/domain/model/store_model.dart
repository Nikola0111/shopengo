import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/home/domain/model/store_model.freezed.dart';

@freezed
class StoreModel with _$StoreModel {
  StoreModel({
    required this.id,
    required this.storeName,
    this.currency,
    this.totalAmountSpentAtStore,
    this.previousShoppingArticlesBought,
    this.previousShoppingDate,
  });

  @override
  final int id;

  @override
  final String storeName;

  @override
  final String? currency;

  @override
  final DateTime? previousShoppingDate;

  @override
  final double? totalAmountSpentAtStore;

  @override
  final int? previousShoppingArticlesBought;
}
