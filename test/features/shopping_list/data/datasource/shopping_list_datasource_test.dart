import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/shopping_list/data/datasource/shopping_list_datasource.dart';

void main() {
  late ShoppingListDatasource datasource;
  late AppDatabase database;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = ShoppingListDatasource(database);
  });

  test('testing fetching no items', () async {
    final items = await datasource.getRandomShoppingItems();
    expect(items.length, 0);
  });

  test('testing creating of shopping item', () async {
    await datasource.createShoppingItem('tomato');
    final items = await datasource.getRandomShoppingItems();
    expect(items.length, 1);
  });
}
