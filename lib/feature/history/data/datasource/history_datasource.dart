import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:drift/drift.dart';

typedef ShoppingHistoryData = ({ShoppingHistoryTableData shopping, List<ShoppingHistoryItemTableData> items});

class HistoryDatasource {
  const new(this._database);
  final AppDatabase _database;

  /// The store's finished shoppings with their bought products, newest first.
  Future<List<ShoppingHistoryData>> getShoppingHistory(int storeId) async {
    final shoppings = await (_database.select(_database.shoppingHistoryTable)
          ..where((t) => t.storeId.equals(storeId))
          ..orderBy([(t) => OrderingTerm.desc(t.date), (t) => OrderingTerm.desc(t.id)]))
        .get();
    final items = await (_database.select(_database.shoppingHistoryItemTable)
          ..where((t) => t.shoppingHistoryId.isIn(shoppings.map((e) => e.id)))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    return [
      for (final shopping in shoppings)
        (shopping: shopping, items: items.where((e) => e.shoppingHistoryId == shopping.id).toList()),
    ];
  }
}
