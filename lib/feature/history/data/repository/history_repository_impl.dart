import 'package:spiskalica/feature/history/data/datasource/history_datasource.dart';
import 'package:spiskalica/feature/history/data/mapper/shopping_history_mapper.dart';
import 'package:spiskalica/feature/history/data/repository/history_repository.dart';
import 'package:spiskalica/feature/history/domain/model/shopping_history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  new(this._historyDatasource, this._shoppingHistoryMapper);

  final HistoryDatasource _historyDatasource;
  final ShoppingHistoryMapper _shoppingHistoryMapper;

  @override
  Future<List<ShoppingHistoryModel>> getShoppingHistory(int storeId) async {
    final data = await _historyDatasource.getShoppingHistory(storeId);
    return _shoppingHistoryMapper.toDomainList(data);
  }
}
