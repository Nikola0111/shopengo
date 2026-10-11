import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getAllStores();
  Future<StoreModel> getStore(int storeId);
  Future<void> setShopping({required int storeId, required bool isShopping});
  Future<void> finishShopping({required int storeId, double? amountSpent});
  Future<int> createStore(String storeName);
  Future<List<StoreModel>> searchByQuery(String query);
}
