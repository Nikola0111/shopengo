import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/cart/domain/model/cart_item_model.freezed.dart';

@freezed
class CartItemModel with _$CartItemModel {
  new({required this.storeId, required this.productId, required this.quantity});

  final int storeId;

  final int productId;

  final int quantity;
}
