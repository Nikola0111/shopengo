import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository.dart';
import 'package:shopengo/feature/product/data/repository/product_repository.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';

class ShoppingPreparationBloc extends Bloc<ShoppingPreparationEvent, ShoppingPreparationState> {
  new(this._productRepository, this._cartRepository, {required this.storeId})
    : super(const ShoppingPreparationState()) {
    _setupEventListeners();
  }

  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final int storeId;

  void _setupEventListeners() {
    on<ShoppingPreparationLoadProductsEvent>((event, emit) async {
      final products = await _productRepository.getAllProducts();
      emit(state.copyWith(products: products, cartQuantities: await _getCartQuantities()));
    });

    on<ShoppingPreparationQueryProductsEvent>((event, emit) {
      emit(state.copyWith(query: event.query));
    });

    on<ShoppingPreparationAddProductEvent>((event, emit) async {
      await _cartRepository.addProduct(storeId: storeId, productId: event.productId);
      emit(state.copyWith(cartQuantities: await _getCartQuantities()));
    });

    on<ShoppingPreparationSubmitProductEvent>((event, emit) async {
      final productName = event.productName.trim();
      if (productName.isEmpty) {
        return;
      }

      final existingProduct = state.products
          .where((e) => e.name.toUpperCase() == productName.toUpperCase())
          .firstOrNull;
      final productId =
          existingProduct?.id ??
          await _productRepository.createProduct(name: productName, amountType: AmountType.piece);
      await _cartRepository.addProduct(storeId: storeId, productId: productId);

      final products = existingProduct == null ? await _productRepository.getAllProducts() : state.products;
      emit(state.copyWith(products: products, query: '', cartQuantities: await _getCartQuantities()));
    });
  }

  Future<Map<int, int>> _getCartQuantities() async {
    final cartItems = await _cartRepository.getCartItems(storeId);
    return {for (final item in cartItems) item.productId: item.quantity};
  }
}
