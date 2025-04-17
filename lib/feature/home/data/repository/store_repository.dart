import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getAllStores();
  Future<StoreModel> createStore(String storeName);
}
