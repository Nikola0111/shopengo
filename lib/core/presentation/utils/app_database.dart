import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part '../../../generated/core/presentation/utils/app_database.g.dart';

@DriftDatabase(tables: [StoreTable, ShoppingItem, ShoppingListEntry])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'shopengo_database',
      native: const DriftNativeOptions(databaseDirectory: getApplicationDocumentsDirectory),
    );
  }

  @override
  int get schemaVersion => 1;
}

class StoreTable extends Table {
  late final id = integer().autoIncrement()();
  late final storeName = text().withLength(min: 0, max: 32)();
  late final currency = text().withLength(min: 0, max: 10).nullable()();
  late final createdAt = dateTime()();
  late final previousShoppingDate = dateTime().nullable()();
  late final previousShoppingAmountSpent = real().nullable()();
  late final previousShoppingArticlesBought = integer().nullable()();
}

class ShoppingItem extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().withLength(min: 0, max: 32)();
}

class ShoppingListEntry extends Table {
  late final storeID = integer().references(StoreTable, #id)();
  late final shoppingItemID = integer().references(ShoppingItem, #id)();
}
