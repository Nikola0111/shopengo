import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl(this._storeDatasource);

  final StoreDatasource _storeDatasource;

  @override
  Future<List<StoreModel>> getAllStores() async {
    final storeData = await _storeDatasource.getAllStores();
    return storeData
        .map(
          (e) => StoreModel(
            id: e.id,
            storeName: e.storeName,
            currency: e.currency,
            previousShoppingAmountSpent: e.previousShoppingAmountSpent,
            previousShoppingArticlesBought: e.previousShoppingArticlesBought,
            previousShoppingDate: e.previousShoppingDate,
          ),
        )
        .toList();
  }

  @override
  Future<StoreModel> createStore(String storeName) async {
    final store = await _storeDatasource.createStore(storeName);
    return StoreModel(id: store.id, storeName: store.storeName);
  }
}
