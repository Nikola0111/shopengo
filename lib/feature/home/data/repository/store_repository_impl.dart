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
