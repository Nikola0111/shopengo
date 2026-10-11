import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/cart/data/datasource/cart_datasource.dart';
import 'package:shopengo/feature/history/data/datasource/history_datasource.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

void main() {
  late AppDatabase database;
  late HistoryDatasource datasource;
  late StoreDatasource storeDatasource;
  late CartDatasource cartDatasource;
  late int maxiId;
  late int lidlId;
  late int milkId;
  late int breadId;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = HistoryDatasource(database);
    storeDatasource = StoreDatasource(database);
    cartDatasource = CartDatasource(database);
    final productDatasource = ProductDatasource(database);
    maxiId = await storeDatasource.createStore('Maxi');
    lidlId = await storeDatasource.createStore('Lidl');
    milkId = await productDatasource.createProduct(name: 'Mleko', amountType: AmountType.liter);
    breadId = await productDatasource.createProduct(name: 'Hleb', amountType: AmountType.piece);
  });

  tearDown(() => database.close());

  Future<void> buy(int storeId, Map<int, int> quantities, {double? amountSpent}) async {
    for (final MapEntry(key: productId, value: quantity) in quantities.entries) {
      for (var i = 0; i < quantity; i++) {
        await cartDatasource.addProduct(storeId: storeId, productId: productId);
      }
      await cartDatasource.toggleChecked(storeId: storeId, productId: productId);
    }
    await storeDatasource.finishShopping(storeId: storeId, amountSpent: amountSpent);
  }

  test('a store without finished shoppings has no history', () async {
    expect(await datasource.getPastShoppings(maxiId), isEmpty);
  });

  test('finishing saves the checked products with their quantities and the amount spent', () async {
    await cartDatasource.addProduct(storeId: maxiId, productId: milkId);
    await cartDatasource.addProduct(storeId: maxiId, productId: milkId);
    await cartDatasource.addProduct(storeId: maxiId, productId: breadId);
    await cartDatasource.toggleChecked(storeId: maxiId, productId: milkId);

    await storeDatasource.finishShopping(storeId: maxiId, amountSpent: 450);

    final (:shopping, :items) = (await datasource.getPastShoppings(maxiId)).single;
    expect(shopping.amountSpent, 450);
    expect(items.single.productName, 'Mleko');
    expect(items.single.amountType, AmountType.liter);
    expect(items.single.quantity, 2);
  });

  test('finishing with nothing checked saves nothing', () async {
    await cartDatasource.addProduct(storeId: maxiId, productId: milkId);

    await storeDatasource.finishShopping(storeId: maxiId);

    expect(await datasource.getPastShoppings(maxiId), isEmpty);
  });

  test('shoppings are newest first and only of the given store', () async {
    await buy(maxiId, {milkId: 1}, amountSpent: 100);
    await buy(lidlId, {milkId: 1}, amountSpent: 200);
    await buy(maxiId, {breadId: 1, milkId: 1}, amountSpent: 300);

    final shoppings = await datasource.getPastShoppings(maxiId);
    expect(shoppings.map((e) => e.shopping.amountSpent), [300, 100]);
    expect(shoppings.first.items.map((e) => e.productName), ['Hleb', 'Mleko']);
    expect(shoppings.last.items.map((e) => e.productName), ['Mleko']);
  });

  test('history keeps bought products after they are deleted', () async {
    await buy(maxiId, {milkId: 3}, amountSpent: 100);

    await (database.delete(database.productTable)..where((t) => t.id.equals(milkId))).go();

    final item = (await datasource.getPastShoppings(maxiId)).single.items.single;
    expect(item.productName, 'Mleko');
    expect(item.quantity, 3);
  });

  test('deleting a store deletes its history', () async {
    await buy(maxiId, {milkId: 1}, amountSpent: 100);

    await (database.delete(database.storeTable)..where((t) => t.id.equals(maxiId))).go();

    expect(await database.select(database.pastShoppingTable).get(), isEmpty);
    expect(await database.select(database.pastShoppingItemTable).get(), isEmpty);
  });
}
