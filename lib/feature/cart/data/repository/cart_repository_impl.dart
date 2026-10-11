import 'package:shopengo/feature/cart/data/datasource/cart_datasource.dart';
import 'package:shopengo/feature/cart/data/mapper/cart_item_mapper.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository.dart';
import 'package:shopengo/feature/cart/domain/model/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  new(this._cartDatasource, this._cartItemMapper);

  final CartDatasource _cartDatasource;
  final CartItemMapper _cartItemMapper;

  @override
  Future<List<CartItemModel>> getCartItems(int storeId) async {
    final cartData = await _cartDatasource.getCartItems(storeId);
    return _cartItemMapper.toDomainList(cartData);
  }

  @override
  Future<void> addProduct({required int storeId, required int productId}) {
    return _cartDatasource.addProduct(storeId: storeId, productId: productId);
  }

  @override
  Future<bool> updateQuantity({required int storeId, required int productId, required int quantity}) {
    return _cartDatasource.updateQuantity(storeId: storeId, productId: productId, quantity: quantity);
  }

  @override
  Future<bool> removeProduct({required int storeId, required int productId}) {
    return _cartDatasource.removeProduct(storeId: storeId, productId: productId);
  }
}
