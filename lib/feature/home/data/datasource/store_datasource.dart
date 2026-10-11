import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';

class StoreDatasource {
  const new(this._database);
  final AppDatabase _database;

  Future<List<StoreTableData>> getAllStores() => _database.storeTable.all().get();

  Future<StoreTableData> getStore(int storeId) =>
      (_database.select(_database.storeTable)..where((t) => t.id.equals(storeId))).getSingle();

  Future<int> createStore(String storeName) async {
    final newStoreID = await _database
        .into(_database.storeTable)
        .insert(StoreTableCompanion.insert(storeName: storeName, createdAt: DateTime.now()));

    return newStoreID;
  }

  Future<void> setShopping({required int storeId, required bool isShopping}) {
    return (_database.update(_database.storeTable)..where((t) => t.id.equals(storeId)))
        .write(StoreTableCompanion(isShopping: Value(isShopping)));
  }

  /// Ends shopping at the store, returning its list to preparation.
  ///
  /// Checked products leave the cart and are saved as the store's previous shopping, together with [amountSpent].
  /// Unchecked ones stay on the list. When nothing is checked, the previous shopping is left as it was.
  Future<void> finishShopping({required int storeId, double? amountSpent}) {
    return _database.transaction(() async {
      final boughtCount = await (_database.delete(_database.cartItemTable)
            ..where((t) => t.storeId.equals(storeId) & t.isChecked.equals(true)))
          .go();
      await (_database.update(_database.storeTable)..where((t) => t.id.equals(storeId))).write(
        boughtCount > 0
            ? StoreTableCompanion(
                isShopping: const Value(false),
                previousShoppingDate: Value(DateTime.now()),
                previousShoppingAmountSpent: Value(amountSpent),
                previousShoppingArticlesBought: Value(boughtCount),
              )
            : const StoreTableCompanion(isShopping: Value(false)),
      );
    });
  }

  // TODO(vaneleey): Implement proper search with where keyword
  Future<List<StoreTableData>> searchByQuery(String query) async {
    final data = await _database.storeTable.all().get();
    data.removeWhere((e) => !e.storeName.toUpperCase().contains(query.toUpperCase()));
    return data;
  }
}
