import 'package:shopengo/feature/history/domain/model/past_shopping_model.dart';

abstract class HistoryRepository {
  Future<List<PastShoppingModel>> getPastShoppings(int storeId);
}
