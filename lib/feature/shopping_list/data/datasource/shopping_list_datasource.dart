import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';

class ShoppingListDatasource {
  const ShoppingListDatasource(this._database);
  final AppDatabase _database;

  Future<void> createShoppingItem(String name) async {
    await _database.into(_database.shoppingItem).insert(ShoppingItemCompanion.insert(name: name));
  }

  Future<List<ShoppingItemData>> getShoppingListByStoreID(int storeID) {
    final query = _database.shoppingItem.select().join([
      innerJoin(
        _database.shoppingListEntry,
        _database.shoppingListEntry.shoppingItemID.equalsExp(_database.shoppingItem.id),
      )
    ])
      ..where(_database.storeTable.id.equals(storeID));

    return query.map((row) => row.readTable(_database.shoppingItem)).get();
  }

  Future<List<ShoppingItemData>> getRandomShoppingItems() async {
    final data = await (_database.shoppingItem.select()..limit(10)).get();
    return data;
  }
}
