import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository.dart';
import 'package:shopengo/feature/category/data/repository/category_repository.dart';
import 'package:shopengo/feature/product/data/repository/product_repository.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';

class ShoppingPreparationBloc extends Bloc<ShoppingPreparationEvent, ShoppingPreparationState> {
  new(this._productRepository, this._cartRepository, this._categoryRepository, {required this.storeId})
    : super(const ShoppingPreparationState()) {
    _setupEventListeners();
  }

  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final CategoryRepository _categoryRepository;
  final int storeId;

  void _setupEventListeners() {
    on<ShoppingPreparationLoadProductsEvent>((event, emit) async {
      final products = await _productRepository.getAllProducts();
      final categories = await _categoryRepository.getAllCategories();
      emit(state.copyWith(products: products, categories: categories, cartQuantities: await _getCartQuantities()));
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
          await _productRepository.createProduct(
            name: productName,
            amountType: event.amountType,
            categoryId: event.categoryId,
          );
      await _cartRepository.addProduct(storeId: storeId, productId: productId);

      if (existingProduct != null) {
        emit(state.copyWith(query: '', cartQuantities: await _getCartQuantities()));
        return;
      }

      // A new product changes its category's product count.
      emit(
        state.copyWith(
          products: await _productRepository.getAllProducts(),
          categories: await _categoryRepository.getAllCategories(),
          query: '',
          cartQuantities: await _getCartQuantities(),
        ),
      );
    });

    on<ShoppingPreparationCreateCategoryEvent>((event, emit) async {
      final title = event.title.trim();
      if (title.isEmpty) {
        return;
      }

      await _categoryRepository.createCategory(title: title, color: event.color);
      emit(state.copyWith(categories: await _categoryRepository.getAllCategories()));
    });
  }

  Future<Map<int, int>> _getCartQuantities() async {
    final cartItems = await _cartRepository.getCartItems(storeId);
    return {for (final item in cartItems) item.productId: item.quantity};
  }
}
