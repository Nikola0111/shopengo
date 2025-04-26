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
}
