import 'package:shopengo/core/presentation/utils/app_database.dart';

class StoreDatasource {
  final _database = AppDatabase();

  Future<List<StoreTableData>> getAllStores() => _database.select(_database.storeTable).get();

  Future<int> createStore(String storeName) async {
    final newStoreID = await _database
        .into(_database.storeTable)
        .insert(StoreTableCompanion.insert(storeName: storeName, createdAt: DateTime.now()));

    return newStoreID;
  }
}
