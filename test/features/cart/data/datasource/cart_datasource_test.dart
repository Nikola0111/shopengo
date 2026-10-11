import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/cart/data/datasource/cart_datasource.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

void main() {
  late AppDatabase database;
  late CartDatasource datasource;
  late ProductDatasource productDatasource;
  late int maxiId;
  late int ideaId;
  late int milkId;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = CartDatasource(database);
    productDatasource = ProductDatasource(database);
    final storeDatasource = StoreDatasource(database);
    maxiId = await storeDatasource.createStore('Maxi');
    ideaId = await storeDatasource.createStore('Idea');
    milkId = await productDatasource.createProduct(name: 'Mleko', amountType: AmountType.liter);
  });

  tearDown(() => database.close());

  test('adding a product twice increments its quantity', () async {
    await datasource.addProduct(storeId: maxiId, productId: milkId);
    await datasource.addProduct(storeId: maxiId, productId: milkId);

    final items = await datasource.getCartItems(maxiId);

    expect(items.single.quantity, 2);
  });

  test('the same product has a separate quantity per store', () async {
    await datasource.addProduct(storeId: maxiId, productId: milkId);
    await datasource.addProduct(storeId: maxiId, productId: milkId);
    await datasource.addProduct(storeId: ideaId, productId: milkId);

    expect((await datasource.getCartItems(maxiId)).single.quantity, 2);
    expect((await datasource.getCartItems(ideaId)).single.quantity, 1);
  });

  test('updating and removing a cart item', () async {
    await datasource.addProduct(storeId: maxiId, productId: milkId);

    expect(await datasource.updateQuantity(storeId: maxiId, productId: milkId, quantity: 5), isTrue);
    expect((await datasource.getCartItems(maxiId)).single.quantity, 5);

    expect(await datasource.removeProduct(storeId: maxiId, productId: milkId), isTrue);
    expect(await datasource.getCartItems(maxiId), isEmpty);
  });

  test('deleting a product removes it from every cart', () async {
    await datasource.addProduct(storeId: maxiId, productId: milkId);
    await datasource.addProduct(storeId: ideaId, productId: milkId);

    await productDatasource.deleteProduct(milkId);

    expect(await datasource.getCartItems(maxiId), isEmpty);
    expect(await datasource.getCartItems(ideaId), isEmpty);
  });

  test('a cart item must point to an existing store and product', () async {
    expect(() => datasource.addProduct(storeId: 999, productId: milkId), throwsA(isA<SqliteException>()));
  });
}
