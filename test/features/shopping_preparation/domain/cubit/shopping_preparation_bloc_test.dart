import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository.dart';
import 'package:shopengo/feature/cart/domain/model/cart_item_model.dart';
import 'package:shopengo/feature/category/data/repository/category_repository.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/data/repository/product_repository.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_bloc.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';

import 'shopping_preparation_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository, CartRepository, CategoryRepository])
void main() {
  late MockProductRepository productRepository;
  late MockCartRepository cartRepository;
  late MockCategoryRepository categoryRepository;

  const storeId = 7;
  final milk = ProductModel(id: 1, name: 'Mleko', amountType: AmountType.liter);
  final bread = ProductModel(id: 2, name: 'Hleb', amountType: AmountType.piece);
  final other = CategoryModel(
    id: CategoryModel.defaultCategoryId,
    title: CategoryModel.defaultCategoryTitle,
    color: const Color(CategoryModel.defaultCategoryColor),
    productCount: 2,
  );
  final baby = CategoryModel(id: 2, title: 'Za bebu', color: const Color(0xFF52B086));

  ShoppingPreparationBloc buildBloc() =>
      ShoppingPreparationBloc(productRepository, cartRepository, categoryRepository, storeId: storeId);

  setUp(() {
    productRepository = MockProductRepository();
    cartRepository = MockCartRepository();
    categoryRepository = MockCategoryRepository();
    when(cartRepository.addProduct(storeId: anyNamed('storeId'), productId: anyNamed('productId')))
        .thenAnswer((_) async {});
  });

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    "should load saved products, categories and this store's cart",
    setUp: () {
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk, bread]);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
      when(cartRepository.getCartItems(storeId))
          .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 3)]);
    },
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingPreparationLoadProductsEvent()),
    expect: () => [
      ShoppingPreparationState(products: [milk, bread], categories: [other], cartQuantities: const {1: 3}),
    ],
  );

  test('should filter products by query, ignoring case', () {
    final state = ShoppingPreparationState(products: [milk, bread], query: 'mle');
    expect(state.filteredProducts, [milk]);
    expect(state.isNewProductQuery, isTrue);
  });

  test('should not treat an existing product name as new', () {
    final state = ShoppingPreparationState(products: [milk, bread], query: ' hleb ');
    expect(state.isNewProductQuery, isFalse);
  });

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    "should add a product to this store's cart",
    setUp: () =>
        when(cartRepository.getCartItems(storeId))
            .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 2)]),
    build: buildBloc,
    seed: () => ShoppingPreparationState(products: [milk], cartQuantities: const {1: 1}),
    act: (bloc) => bloc.add(ShoppingPreparationAddProductEvent(productId: 1)),
    expect: () => [
      ShoppingPreparationState(products: [milk], cartQuantities: const {1: 2}),
    ],
    verify: (_) => verify(cartRepository.addProduct(storeId: storeId, productId: 1)).called(1),
  );

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    'should add an existing product to the cart when its name is submitted',
    setUp: () =>
        when(cartRepository.getCartItems(storeId))
            .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 1)]),
    build: buildBloc,
    seed: () => ShoppingPreparationState(products: [milk], query: 'mleko'),
    act: (bloc) => bloc.add(ShoppingPreparationSubmitProductEvent(productName: 'mleko')),
    expect: () => [
      ShoppingPreparationState(products: [milk], cartQuantities: const {1: 1}),
    ],
    verify: (_) {
      verifyNever(productRepository.createProduct(name: anyNamed('name'), amountType: anyNamed('amountType')));
      verify(cartRepository.addProduct(storeId: storeId, productId: 1)).called(1);
    },
  );

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    'should create a new product as piece, add it to the cart and refresh category counts',
    setUp: () {
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
      when(productRepository.createProduct(name: 'Hleb', amountType: AmountType.piece)).thenAnswer((_) async => 2);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk, bread]);
      when(cartRepository.getCartItems(storeId))
          .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 2, quantity: 1)]);
    },
    build: buildBloc,
    seed: () => ShoppingPreparationState(products: [milk], query: 'Hleb '),
    act: (bloc) => bloc.add(ShoppingPreparationSubmitProductEvent(productName: 'Hleb ')),
    expect: () => [
      ShoppingPreparationState(products: [milk, bread], categories: [other], cartQuantities: const {2: 1}),
    ],
    verify: (_) => verify(cartRepository.addProduct(storeId: storeId, productId: 2)).called(1),
  );

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    'should ignore a blank product name',
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingPreparationSubmitProductEvent(productName: '   ')),
    expect: () => <ShoppingPreparationState>[],
  );

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    'should create a category and reload categories',
    setUp: () {
      when(categoryRepository.createCategory(title: 'Za bebu', color: const Color(0xFF52B086)))
          .thenAnswer((_) async => 2);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other, baby]);
    },
    build: buildBloc,
    seed: () => ShoppingPreparationState(categories: [other]),
    act: (bloc) => bloc.add(ShoppingPreparationCreateCategoryEvent(title: ' Za bebu ', color: const Color(0xFF52B086))),
    expect: () => [
      ShoppingPreparationState(categories: [other, baby]),
    ],
  );

  blocTest<ShoppingPreparationBloc, ShoppingPreparationState>(
    'should ignore a blank category title',
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingPreparationCreateCategoryEvent(title: '  ', color: const Color(0xFF52B086))),
    expect: () => <ShoppingPreparationState>[],
  );
}
