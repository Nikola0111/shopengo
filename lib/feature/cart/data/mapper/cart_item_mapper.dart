import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/cart/domain/model/cart_item_model.dart';

class CartItemMapper {
  const new();

  CartItemModel toDomain(CartItemTableData data) {
    return CartItemModel(storeId: data.storeId, productId: data.productId, quantity: data.quantity);
  }

  List<CartItemModel> toDomainList(List<CartItemTableData> data) => data.map(toDomain).toList();
}
