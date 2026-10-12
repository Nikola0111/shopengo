import 'package:basketwise/feature/history/domain/model/shopping_history_model.dart';

abstract class HistoryRepository {
  Future<List<ShoppingHistoryModel>> getShoppingHistory(int storeId);
}
