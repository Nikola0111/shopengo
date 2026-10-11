import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';

typedef PastShoppingData = ({PastShoppingTableData shopping, List<PastShoppingItemTableData> items});

class HistoryDatasource {
  const new(this._database);
  final AppDatabase _database;

  /// The store's finished shoppings with their bought products, newest first.
  Future<List<PastShoppingData>> getPastShoppings(int storeId) async {
    final shoppings = await (_database.select(_database.pastShoppingTable)
          ..where((t) => t.storeId.equals(storeId))
          ..orderBy([(t) => OrderingTerm.desc(t.date), (t) => OrderingTerm.desc(t.id)]))
        .get();
    final items = await (_database.select(_database.pastShoppingItemTable)
          ..where((t) => t.pastShoppingId.isIn(shoppings.map((e) => e.id)))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    return [
      for (final shopping in shoppings)
        (shopping: shopping, items: items.where((e) => e.pastShoppingId == shopping.id).toList()),
    ];
  }
}
