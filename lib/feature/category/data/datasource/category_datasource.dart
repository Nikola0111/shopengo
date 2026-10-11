import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';

class CategoryDatasource {
  const new(this._database);
  final AppDatabase _database;

  /// Every category paired with the number of products in it, with the default category last.
  Future<List<(CategoryTableData, int)>> getAllCategories() {
    final productCount = _database.productTable.id.count();
    final query =
        _database.select(_database.categoryTable).join([
            leftOuterJoin(
              _database.productTable,
              _database.productTable.categoryId.equalsExp(_database.categoryTable.id),
              useColumns: false,
            ),
          ])
          ..addColumns([productCount])
          ..groupBy([_database.categoryTable.id])
          ..orderBy([
            OrderingTerm.asc(_database.categoryTable.id.equals(CategoryModel.defaultCategoryId)),
            OrderingTerm.asc(_database.categoryTable.id),
          ]);

    return query.map((row) => (row.readTable(_database.categoryTable), row.read(productCount) ?? 0)).get();
  }

  Future<int> createCategory({required String title, required int color}) {
    return _database.into(_database.categoryTable).insert(CategoryTableCompanion.insert(title: title, color: color));
  }
}
