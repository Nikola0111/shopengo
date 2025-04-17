import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part '../../../../generated/feature/home/data/tables/store_table.g.dart';

class StoreTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 0, max: 32)();
}

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
