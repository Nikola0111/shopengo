import 'dart:ui';

import 'package:basketwise/feature/cart/data/repository/cart_repository.dart';
import 'package:basketwise/feature/cart/domain/model/cart_item_model.dart';
import 'package:basketwise/feature/category/data/repository/category_repository.dart';
import 'package:basketwise/feature/category/domain/model/category_model.dart';
import 'package:basketwise/feature/home/data/repository/store_repository.dart';
import 'package:basketwise/feature/home/domain/model/store_model.dart';
import 'package:basketwise/feature/product/data/repository/product_repository.dart';
import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:basketwise/feature/product/domain/model/product_model.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_bloc.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_event.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_state.dart';
import 'package:basketwise/feature/shopping/domain/model/shopping_list_item_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'shopping_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository, CartRepository, CategoryRepository, StoreRepository])
void main() {
  late MockProductRepository productRepository;
  late MockCartRepository cartRepository;
  late MockCategoryRepository categoryRepository;
  late MockStoreRepository storeRepository;

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

  ShoppingBloc buildBloc() =>
      ShoppingBloc(productRepository, cartRepository, categoryRepository, storeRepository, storeId: storeId);

  setUp(() {
    productRepository = MockProductRepository();
    cartRepository = MockCartRepository();
    categoryRepository = MockCategoryRepository();
    storeRepository = MockStoreRepository();
    when(cartRepository.addProduct(storeId: anyNamed('storeId'), productId: anyNamed('productId')))
        .thenAnswer((_) async {});
  });

  blocTest<ShoppingBloc, ShoppingState>(
    "should load saved products, categories, this store's cart, whether it's being shopped and the previous amount",
    setUp: () {
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk, bread]);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
      when(storeRepository.getStore(storeId)).thenAnswer(
        (_) async => StoreModel(id: storeId, storeName: 'Maxi', isShopping: true, previousShoppingAmountSpent: 3000),
      );
      when(cartRepository.getCartItems(storeId)).thenAnswer(
        (_) async => [
          CartItemModel(storeId: storeId, productId: 1, quantity: 3),
          CartItemModel(storeId: storeId, productId: 2, quantity: 1, isChecked: true),
        ],
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingLoadProductsEvent()),
    expect: () => [
      ShoppingState(
        products: [milk, bread],
        categories: [other],
        cartQuantities: const {1: 3, 2: 1},
        checkedProductIds: const {2},
        isShopping: true,
        previousShoppingAmountSpent: 3000,
      ),
    ],
  );

  test('should filter products by query, ignoring case', () {
    final state = ShoppingState(products: [milk, bread], query: 'mle');
    expect(state.filteredProducts, [milk]);
    expect(state.isNewProductQuery, isTrue);
  });

  test('should not treat an existing product name as new', () {
    final state = ShoppingState(products: [milk, bread], query: ' hleb ');
    expect(state.isNewProductQuery, isFalse);
  });

  blocTest<ShoppingBloc, ShoppingState>(
    "should add a product to this store's cart",
    setUp: () =>
        when(cartRepository.getCartItems(storeId))
            .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 2)]),
    build: buildBloc,
    seed: () => ShoppingState(products: [milk], cartQuantities: const {1: 1}),
    act: (bloc) => bloc.add(ShoppingAddProductEvent(productId: 1)),
    expect: () => [
      ShoppingState(products: [milk], cartQuantities: const {1: 2}),
    ],
    verify: (_) => verify(cartRepository.addProduct(storeId: storeId, productId: 1)).called(1),
  );

  test("should group this store's cart products by category, in category order", () {
    final diapers = ProductModel(id: 3, name: 'Pelene', amountType: AmountType.pack, categoryId: baby.id);
    final state = ShoppingState(
      products: [milk, bread, diapers],
      categories: [baby, other],
      cartQuantities: const {1: 2, 3: 1},
    );
    expect(state.shoppingList.map((e) => e.category), [baby, other]);
    expect(state.shoppingList.map((e) => e.items), [
      [ShoppingListItemModel(product: diapers, quantity: 1)],
      [ShoppingListItemModel(product: milk, quantity: 2)],
    ]);
  });

  test('should have an empty shopping list when the cart is empty', () {
    final state = ShoppingState(products: [milk, bread], categories: [other]);
    expect(state.shoppingList, isEmpty);
  });

  blocTest<ShoppingBloc, ShoppingState>(
    "should take a product off this store's cart and reload it",
    setUp: () {
      when(cartRepository.decreaseQuantity(storeId: storeId, productId: 1)).thenAnswer((_) async {});
      when(cartRepository.getCartItems(storeId)).thenAnswer((_) async => []);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk], cartQuantities: const {1: 1}),
    act: (bloc) => bloc.add(ShoppingDecreaseQuantityEvent(productId: 1)),
    expect: () => [
      ShoppingState(products: [milk]),
    ],
    verify: (_) => verify(cartRepository.decreaseQuantity(storeId: storeId, productId: 1)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should add an existing product to the cart when its name is submitted',
    setUp: () =>
        when(cartRepository.getCartItems(storeId))
            .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 1)]),
    build: buildBloc,
    seed: () => ShoppingState(products: [milk], query: 'mleko'),
    act: (bloc) => bloc.add(ShoppingSubmitProductEvent(productName: 'mleko')),
    expect: () => [
      ShoppingState(products: [milk], cartQuantities: const {1: 1}),
    ],
    verify: (_) {
      verifyNever(productRepository.createProduct(name: anyNamed('name'), amountType: anyNamed('amountType')));
      verify(cartRepository.addProduct(storeId: storeId, productId: 1)).called(1);
    },
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should create a new product as piece, add it to the cart and refresh category counts',
    setUp: () {
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
      when(productRepository.createProduct(name: 'Hleb', amountType: AmountType.piece)).thenAnswer((_) async => 2);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk, bread]);
      when(cartRepository.getCartItems(storeId))
          .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 2, quantity: 1)]);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk], query: 'Hleb '),
    act: (bloc) => bloc.add(ShoppingSubmitProductEvent(productName: 'Hleb ')),
    expect: () => [
      ShoppingState(products: [milk, bread], categories: [other], cartQuantities: const {2: 1}),
    ],
    verify: (_) => verify(cartRepository.addProduct(storeId: storeId, productId: 2)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should create a new product with the chosen unit and category',
    setUp: () {
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other, baby]);
      when(productRepository.createProduct(name: 'Pelene', amountType: AmountType.pack, categoryId: baby.id))
          .thenAnswer((_) async => 3);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk]);
      when(cartRepository.getCartItems(storeId)).thenAnswer((_) async => []);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk], categories: [other, baby]),
    act: (bloc) => bloc.add(
      ShoppingSubmitProductEvent(productName: 'Pelene', amountType: AmountType.pack, categoryId: baby.id),
    ),
    verify: (_) {
      verify(productRepository.createProduct(name: 'Pelene', amountType: AmountType.pack, categoryId: baby.id))
          .called(1);
      verify(cartRepository.addProduct(storeId: storeId, productId: 3)).called(1);
    },
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should ignore a blank product name',
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingSubmitProductEvent(productName: '   ')),
    expect: () => <ShoppingState>[],
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should save an edited product with a trimmed name and refresh category counts',
    setUp: () {
      final editedMilk = milk.copyWith(name: 'Mleko 2%', amountType: AmountType.pack, categoryId: baby.id);
      when(productRepository.updateProduct(editedMilk)).thenAnswer((_) async => true);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [editedMilk, bread]);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other, baby]);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk, bread], categories: [other]),
    act: (bloc) => bloc.add(
      ShoppingUpdateProductEvent(
        product: milk.copyWith(name: ' Mleko 2% ', amountType: AmountType.pack, categoryId: baby.id),
      ),
    ),
    expect: () => [
      ShoppingState(
        products: [milk.copyWith(name: 'Mleko 2%', amountType: AmountType.pack, categoryId: baby.id), bread],
        categories: [other, baby],
      ),
    ],
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should keep a product unchanged when edited to a blank or taken name',
    build: buildBloc,
    seed: () => ShoppingState(products: [milk, bread]),
    act: (bloc) => bloc
      ..add(ShoppingUpdateProductEvent(product: milk.copyWith(name: '  ')))
      ..add(ShoppingUpdateProductEvent(product: milk.copyWith(name: 'hleb'))),
    expect: () => <ShoppingState>[],
    verify: (_) => verifyNever(productRepository.updateProduct(any)),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should delete a product and reload products, categories and the cart',
    setUp: () {
      when(productRepository.deleteProduct(1)).thenAnswer((_) async => true);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [bread]);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
      when(cartRepository.getCartItems(storeId)).thenAnswer((_) async => []);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk, bread], cartQuantities: const {1: 2}),
    act: (bloc) => bloc.add(ShoppingDeleteProductEvent(productId: 1)),
    expect: () => [
      ShoppingState(products: [bread], categories: [other]),
    ],
    verify: (_) => verify(productRepository.deleteProduct(1)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should create a category and reload categories',
    setUp: () {
      when(categoryRepository.createCategory(title: 'Za bebu', color: const Color(0xFF52B086)))
          .thenAnswer((_) async => 2);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other, baby]);
    },
    build: buildBloc,
    seed: () => ShoppingState(categories: [other]),
    act: (bloc) => bloc.add(ShoppingCreateCategoryEvent(title: ' Za bebu ', color: const Color(0xFF52B086))),
    expect: () => [
      ShoppingState(categories: [other, baby]),
    ],
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should save an edited category with a trimmed title',
    setUp: () {
      when(categoryRepository.updateCategory(id: baby.id, title: 'Beba', color: const Color(0xFF4EA4DF)))
          .thenAnswer((_) async => true);
      when(categoryRepository.getAllCategories())
          .thenAnswer((_) async => [baby.copyWith(title: 'Beba', color: const Color(0xFF4EA4DF)), other]);
    },
    build: buildBloc,
    seed: () => ShoppingState(categories: [baby, other]),
    act: (bloc) => bloc.add(
      ShoppingUpdateCategoryEvent(categoryId: baby.id, title: ' Beba ', color: const Color(0xFF4EA4DF)),
    ),
    expect: () => [
      ShoppingState(categories: [baby.copyWith(title: 'Beba', color: const Color(0xFF4EA4DF)), other]),
    ],
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should not change the default category',
    build: buildBloc,
    seed: () => ShoppingState(categories: [other]),
    act: (bloc) => bloc
      ..add(ShoppingUpdateCategoryEvent(categoryId: other.id, title: 'Razno', color: const Color(0xFF4EA4DF)))
      ..add(ShoppingDeleteCategoryEvent(categoryId: other.id)),
    expect: () => <ShoppingState>[],
    verify: (_) => verifyNever(categoryRepository.deleteCategory(any)),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should delete a category and reload products, which move to the default category',
    setUp: () {
      when(categoryRepository.deleteCategory(baby.id)).thenAnswer((_) async => true);
      when(productRepository.getAllProducts()).thenAnswer((_) async => [milk]);
      when(categoryRepository.getAllCategories()).thenAnswer((_) async => [other]);
    },
    build: buildBloc,
    seed: () => ShoppingState(products: [milk.copyWith(categoryId: baby.id)], categories: [baby, other]),
    act: (bloc) => bloc.add(ShoppingDeleteCategoryEvent(categoryId: baby.id)),
    expect: () => [
      ShoppingState(products: [milk], categories: [other]),
    ],
    verify: (_) => verify(categoryRepository.deleteCategory(baby.id)).called(1),
  );

  test('should fall back to the default category once a selected one is deleted', () {
    final state = ShoppingState(categories: [baby, other]);
    expect(state.existingCategoryId(baby.id), baby.id);
    expect(state.existingCategoryId(99), CategoryModel.defaultCategoryId);
  });

  blocTest<ShoppingBloc, ShoppingState>(
    'should ignore a blank category title',
    build: buildBloc,
    act: (bloc) => bloc.add(ShoppingCreateCategoryEvent(title: '  ', color: const Color(0xFF52B086))),
    expect: () => <ShoppingState>[],
  );

  test('should mark checked products on the shopping list', () {
    final state = ShoppingState(
      products: [milk, bread],
      categories: [other],
      cartQuantities: const {1: 2, 2: 1},
      checkedProductIds: const {2},
    );
    expect(state.shoppingList.single.items, [
      ShoppingListItemModel(product: milk, quantity: 2),
      ShoppingListItemModel(product: bread, quantity: 1, isChecked: true),
    ]);
  });

  blocTest<ShoppingBloc, ShoppingState>(
    'should start shopping',
    setUp: () =>
        when(storeRepository.setShopping(storeId: storeId, isShopping: true)).thenAnswer((_) async {}),
    build: buildBloc,
    seed: () => const ShoppingState(cartQuantities: {1: 1}),
    act: (bloc) => bloc.add(ShoppingStartShoppingEvent()),
    expect: () => [
      const ShoppingState(cartQuantities: {1: 1}, isShopping: true),
    ],
    verify: (_) => verify(storeRepository.setShopping(storeId: storeId, isShopping: true)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should go back to preparation, keeping checked products',
    setUp: () =>
        when(storeRepository.setShopping(storeId: storeId, isShopping: false)).thenAnswer((_) async {}),
    build: buildBloc,
    seed: () => const ShoppingState(cartQuantities: {1: 1}, checkedProductIds: {1}, isShopping: true),
    act: (bloc) => bloc.add(ShoppingBackToPreparationEvent()),
    expect: () => [
      const ShoppingState(cartQuantities: {1: 1}, checkedProductIds: {1}),
    ],
    verify: (_) => verify(storeRepository.setShopping(storeId: storeId, isShopping: false)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should check a product off and reload the cart',
    setUp: () {
      when(cartRepository.toggleChecked(storeId: storeId, productId: 1)).thenAnswer((_) async {});
      when(cartRepository.getCartItems(storeId))
          .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 1, quantity: 2, isChecked: true)]);
    },
    build: buildBloc,
    seed: () => const ShoppingState(cartQuantities: {1: 2}, isShopping: true),
    act: (bloc) => bloc.add(ShoppingToggleCheckedEvent(productId: 1)),
    expect: () => [
      const ShoppingState(cartQuantities: {1: 2}, checkedProductIds: {1}, isShopping: true),
    ],
    verify: (_) => verify(cartRepository.toggleChecked(storeId: storeId, productId: 1)).called(1),
  );

  blocTest<ShoppingBloc, ShoppingState>(
    'should finish shopping, leaving unchecked products on the list and making it the previous shopping',
    setUp: () {
      when(storeRepository.finishShopping(storeId: storeId, amountSpent: 3000)).thenAnswer((_) async {});
      when(storeRepository.getStore(storeId))
          .thenAnswer((_) async => StoreModel(id: storeId, storeName: 'Maxi', previousShoppingAmountSpent: 3000));
      when(cartRepository.getCartItems(storeId))
          .thenAnswer((_) async => [CartItemModel(storeId: storeId, productId: 2, quantity: 1)]);
    },
    build: buildBloc,
    seed: () => const ShoppingState(
      cartQuantities: {1: 2, 2: 1},
      checkedProductIds: {1},
      isShopping: true,
      previousShoppingAmountSpent: 1200,
    ),
    act: (bloc) => bloc.add(ShoppingFinishEvent(amountSpent: 3000)),
    expect: () => [
      const ShoppingState(cartQuantities: {2: 1}, previousShoppingAmountSpent: 3000),
    ],
    verify: (_) => verify(storeRepository.finishShopping(storeId: storeId, amountSpent: 3000)).called(1),
  );
}
