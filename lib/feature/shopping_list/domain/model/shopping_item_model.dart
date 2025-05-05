import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/shopping_list/domain/model/shopping_item_model.freezed.dart';

@freezed
class ShoppingItemModel with _$ShoppingItemModel {
  ShoppingItemModel({
    required this.id,
    required this.name,
  });

  @override
  final int id;

  @override
  final String name;
}
