import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository.dart';
import 'package:shopengo/feature/category/data/repository/category_repository.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/product/data/repository/product_repository.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_event.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  new(
    this._productRepository,
    this._cartRepository,
    this._categoryRepository,
    this._storeRepository, {
    required this.storeId,
    bool isShopping = false,
  }) : super(ShoppingState(isShopping: isShopping)) {
    _setupEventListeners();
  }

  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final CategoryRepository _categoryRepository;
  final StoreRepository _storeRepository;
  final int storeId;

  void _setupEventListeners() {
    on<ShoppingLoadProductsEvent>((event, emit) async {
      final products = await _productRepository.getAllProducts();
      final categories = await _categoryRepository.getAllCategories();
      final store = await _storeRepository.getStore(storeId);
      emit(
        await _withReloadedCart(
          state.copyWith(products: products, categories: categories, isShopping: store.isShopping),
        ),
      );
    });

    on<ShoppingQueryProductsEvent>((event, emit) {
      emit(state.copyWith(query: event.query));
    });

    on<ShoppingAddProductEvent>((event, emit) async {
      await _cartRepository.addProduct(storeId: storeId, productId: event.productId);
      emit(await _withReloadedCart(state));
    });

    on<ShoppingDecreaseQuantityEvent>((event, emit) async {
      await _cartRepository.decreaseQuantity(storeId: storeId, productId: event.productId);
      emit(await _withReloadedCart(state));
    });

    on<ShoppingSubmitProductEvent>((event, emit) async {
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
        emit(await _withReloadedCart(state.copyWith(query: '')));
        return;
      }

      // A new product changes its category's product count.
      emit(
        await _withReloadedCart(
          state.copyWith(
            products: await _productRepository.getAllProducts(),
            categories: await _categoryRepository.getAllCategories(),
            query: '',
          ),
        ),
      );
    });

    on<ShoppingCreateCategoryEvent>((event, emit) async {
      final title = event.title.trim();
      if (title.isEmpty) {
        return;
      }

      await _categoryRepository.createCategory(title: title, color: event.color);
      emit(state.copyWith(categories: await _categoryRepository.getAllCategories()));
    });

    on<ShoppingStartShoppingEvent>((event, emit) async {
      await _storeRepository.setShopping(storeId: storeId, isShopping: true);
      emit(state.copyWith(isShopping: true));
    });

    on<ShoppingBackToPreparationEvent>((event, emit) async {
      await _storeRepository.setShopping(storeId: storeId, isShopping: false);
      emit(state.copyWith(isShopping: false));
    });

    on<ShoppingToggleCheckedEvent>((event, emit) async {
      await _cartRepository.toggleChecked(storeId: storeId, productId: event.productId);
      emit(await _withReloadedCart(state));
    });

    on<ShoppingFinishEvent>((event, emit) async {
      await _storeRepository.finishShopping(storeId: storeId, amountSpent: event.amountSpent);
      emit(await _withReloadedCart(state.copyWith(isShopping: false)));
    });
  }

  /// Copies [state] with this store's cart reloaded.
  Future<ShoppingState> _withReloadedCart(ShoppingState state) async {
    final cartItems = await _cartRepository.getCartItems(storeId);
    return state.copyWith(
      cartQuantities: {for (final item in cartItems) item.productId: item.quantity},
      checkedProductIds: {
        for (final item in cartItems)
          if (item.isChecked) item.productId,
      },
    );
  }
}
