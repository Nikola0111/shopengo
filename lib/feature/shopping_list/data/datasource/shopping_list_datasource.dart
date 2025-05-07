import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';

class ShoppingListDatasource {
  const ShoppingListDatasource(this._database);
  final AppDatabase _database;

  Future<int> createShoppingItem(String name) async {
    final id = await _database.into(_database.shoppingItem).insert(ShoppingItemCompanion.insert(name: name));
    return id;
  }

  Future<List<ShoppingItemData>> getShoppingListByStoreID(int storeID) {
    final query = _database.shoppingItem.select().join([
      innerJoin(
        _database.shoppingListEntry,
        _database.shoppingListEntry.shoppingItemID.equalsExp(_database.shoppingItem.id),
      )
    ])
      ..where(_database.shoppingListEntry.storeID.equals(storeID));

    return query.map((row) => row.readTable(_database.shoppingItem)).get();
  }

  Future<List<ShoppingItemData>> getRandomShoppingItems(List<int> excludedShoppingItemIDs) async {
    final data = await (_database.shoppingItem.select()
          ..limit(10)
          ..where((e) => e.id.isNotIn(excludedShoppingItemIDs)))
        .get();
    return data;
  }

  Future<void> insertShoppingItemEntry({required int storeID, required int shoppingItemID}) async {
    await _database
        .into(_database.shoppingListEntry)
        .insert(ShoppingListEntryCompanion(storeID: Value(storeID), shoppingItemID: Value(shoppingItemID)));
  }

  Future<void> removeShoppingItemEntry({required int storeID, required int shoppingItemID}) async {
    await (_database.shoppingListEntry.delete()
          ..where((e) => e.storeID.equals(storeID) & e.shoppingItemID.equals(shoppingItemID)))
        .go();
  }
}
