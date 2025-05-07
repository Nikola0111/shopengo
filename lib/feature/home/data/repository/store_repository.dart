import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getAllStores();
  Future<int> createStore(String storeName);
  Future<StoreModel> getStoreByID(int storeID);
  Future<List<StoreModel>> searchByQuery(String query);
}
