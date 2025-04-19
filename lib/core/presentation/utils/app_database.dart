import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part '../../../generated/core/presentation/utils/app_database.g.dart';

@DriftDatabase(tables: [StoreTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

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
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storeName => text().withLength(min: 0, max: 32)();
  TextColumn get currency => text().withLength(min: 0, max: 10).nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get previousShoppingDate => dateTime().nullable()();
  RealColumn get previousShoppingAmountSpent => real().nullable()();
  IntColumn get previousShoppingArticlesBought => integer().nullable()();
}
