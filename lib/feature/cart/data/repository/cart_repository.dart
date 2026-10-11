import 'package:shopengo/feature/cart/domain/model/cart_item_model.dart';

abstract class CartRepository {
  Future<List<CartItemModel>> getCartItems(int storeId);
  Future<void> addProduct({required int storeId, required int productId});
  Future<bool> updateQuantity({required int storeId, required int productId, required int quantity});
  Future<bool> removeProduct({required int storeId, required int productId});
}
