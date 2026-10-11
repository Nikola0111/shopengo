import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

part '../../../generated/core/presentation/utils/app_database.g.dart';

@DriftDatabase(tables: [StoreTable, CategoryTable, ProductTable, CartItemTable])
class AppDatabase extends _$AppDatabase {
  new([QueryExecutor? executor]) : super(executor ?? _openConnection());

  // Named constructor for creating in-memory database
  new forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'shopengo_database',
      native: const DriftNativeOptions(databaseDirectory: getApplicationDocumentsDirectory),
    );
  }

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedDefaultCategory();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(productTable);
      }
      if (from < 3) {
        await m.createTable(cartItemTable);
      }
      if (from < 4) {
        await m.createTable(categoryTable);
        await _seedDefaultCategory();
        // Existing products land in the default category through the column's default value.
        await m.addColumn(productTable, productTable.categoryId);
      }
    },
    // SQLite ignores foreign keys unless they're enabled per connection.
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );

  Future<void> _seedDefaultCategory() {
    return into(categoryTable).insert(
      CategoryTableCompanion.insert(
        id: const Value(CategoryModel.defaultCategoryId),
        title: CategoryModel.defaultCategoryTitle,
        color: CategoryModel.defaultCategoryColor,
      ),
    );
  }
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

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  // ARGB color value.
  IntColumn get color => integer()();
}

class ProductTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  TextColumn get amountType => textEnum<AmountType>()();
  // Products of a deleted category fall back to the default one.
  IntColumn get categoryId => integer()
      .references(CategoryTable, #id, onDelete: KeyAction.setDefault)
      .withDefault(const Constant(CategoryModel.defaultCategoryId))();
}

/// How many of a product are in a store's cart. Products are shared by all stores.
class CartItemTable extends Table {
  IntColumn get storeId => integer().references(StoreTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(ProductTable, #id, onDelete: KeyAction.cascade)();
  // Drift's check constraints reference the column's own getter.
  // ignore: recursive_getters
  IntColumn get quantity => integer().check(quantity.isBiggerThanValue(0))();

  @override
  Set<Column<Object>> get primaryKey => {storeId, productId};
}
