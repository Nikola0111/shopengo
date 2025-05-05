import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getAllStores();
  Future<int> createStore(String storeName);
  Future<List<StoreModel>> searchByQuery(String query);
}
