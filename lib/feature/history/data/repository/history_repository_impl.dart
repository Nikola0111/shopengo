import 'package:shopengo/feature/history/data/datasource/history_datasource.dart';
import 'package:shopengo/feature/history/data/mapper/past_shopping_mapper.dart';
import 'package:shopengo/feature/history/data/repository/history_repository.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  new(this._historyDatasource, this._pastShoppingMapper);

  final HistoryDatasource _historyDatasource;
  final PastShoppingMapper _pastShoppingMapper;

  @override
  Future<List<PastShoppingModel>> getPastShoppings(int storeId) async {
    final data = await _historyDatasource.getPastShoppings(storeId);
    return _pastShoppingMapper.toDomainList(data);
  }
}
