import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/mapper/store_mapper.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

class StoreRepositoryImpl implements StoreRepository {
  new(this._storeDatasource, this._storeMapper);

  final StoreDatasource _storeDatasource;
  final StoreMapper _storeMapper;

  @override
  Future<List<StoreModel>> getAllStores() async {
    final storeData = await _storeDatasource.getAllStores();
    return _storeMapper.toDomainList(storeData);
  }

  @override
  Future<StoreModel> getStore(int storeId) async {
    final storeData = await _storeDatasource.getStore(storeId);
    return _storeMapper.toDomain(storeData);
  }

  @override
  Future<void> setShopping({required int storeId, required bool isShopping}) {
    return _storeDatasource.setShopping(storeId: storeId, isShopping: isShopping);
  }

  @override
  Future<void> finishShopping({required int storeId, double? amountSpent}) {
    return _storeDatasource.finishShopping(storeId: storeId, amountSpent: amountSpent);
  }

  @override
  Future<int> createStore(String storeName) async {
    final id = await _storeDatasource.createStore(storeName);
    return id;
  }

  @override
  Future<List<StoreModel>> searchByQuery(String query) async {
    final storeData = await _storeDatasource.searchByQuery(query);
    return _storeMapper.toDomainList(storeData);
  }
}
