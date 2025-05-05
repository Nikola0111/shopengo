import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';

class StoreDatasource {
  const StoreDatasource(this._database);
  final AppDatabase _database;

  Future<List<StoreTableData>> getAllStores() => _database.storeTable.all().get();

  Future<int> createStore(String storeName) async {
    final newStoreID = await _database
        .into(_database.storeTable)
        .insert(StoreTableCompanion.insert(storeName: storeName, createdAt: DateTime.now()));

    return newStoreID;
  }

  // TODO(vaneleey): Implement proper search with where keyword
  Future<List<StoreTableData>> searchByQuery(String query) async {
    final q = '%${query.toLowerCase()}%';
    final data = await (_database.storeTable.select()..where((e) => e.storeName.lower().like(q))).get();
    return data;
  }
}
