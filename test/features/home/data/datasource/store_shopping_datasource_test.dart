import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:basketwise/feature/cart/data/datasource/cart_datasource.dart';
import 'package:basketwise/feature/home/data/datasource/store_datasource.dart';
import 'package:basketwise/feature/product/data/datasource/product_datasource.dart';
import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late StoreDatasource datasource;
  late CartDatasource cartDatasource;
  late int maxiId;
  late int milkId;
  late int breadId;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = StoreDatasource(database);
    cartDatasource = CartDatasource(database);
    final productDatasource = ProductDatasource(database);
    maxiId = await datasource.createStore('Maxi');
    milkId = await productDatasource.createProduct(name: 'Mleko', amountType: AmountType.liter);
    breadId = await productDatasource.createProduct(name: 'Hleb', amountType: AmountType.piece);
    await cartDatasource.addProduct(storeId: maxiId, productId: milkId);
    await cartDatasource.addProduct(storeId: maxiId, productId: breadId);
  });

  tearDown(() => database.close());

  test('a new store is being prepared', () async {
    expect((await datasource.getStore(maxiId)).isShopping, isFalse);
  });

  test('starting and stopping shopping', () async {
    await datasource.setShopping(storeId: maxiId, isShopping: true);
    expect((await datasource.getStore(maxiId)).isShopping, isTrue);

    await datasource.setShopping(storeId: maxiId, isShopping: false);
    expect((await datasource.getStore(maxiId)).isShopping, isFalse);
  });

  test('finishing saves checked products as the previous shopping and keeps unchecked ones', () async {
    await datasource.setShopping(storeId: maxiId, isShopping: true);
    await cartDatasource.toggleChecked(storeId: maxiId, productId: milkId);

    await datasource.finishShopping(storeId: maxiId, amountSpent: 3000);

    final store = await datasource.getStore(maxiId);
    expect(store.isShopping, isFalse);
    expect(store.previousShoppingAmountSpent, 3000);
    expect(store.previousShoppingArticlesBought, 1);
    expect(store.previousShoppingDate, isNotNull);
    expect((await cartDatasource.getCartItems(maxiId)).single.productId, breadId);
  });

  test('finishing with nothing checked keeps the list and the previous shopping', () async {
    await datasource.setShopping(storeId: maxiId, isShopping: true);

    await datasource.finishShopping(storeId: maxiId);

    final store = await datasource.getStore(maxiId);
    expect(store.isShopping, isFalse);
    expect(store.previousShoppingDate, isNull);
    expect(store.previousShoppingAmountSpent, isNull);
    expect(await cartDatasource.getCartItems(maxiId), hasLength(2));
  });
}
