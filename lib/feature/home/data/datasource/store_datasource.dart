import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

class StoreDatasource {
  final _database = AppDatabase();

  Future<List<StoreTableData>> getAllStores() => _database.select(_database.storeTable).get();

  Future<StoreTableData> createStore(String storeName) async {
    final newStoreID = await _database
        .into(_database.storeTable)
        .insert(StoreTableCompanion.insert(storeName: storeName));

    return StoreTableData(id: newStoreID, storeName: storeName);
  }
}
