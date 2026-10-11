import 'package:drift/drift.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

class ProductDatasource {
  const new(this._database);
  final AppDatabase _database;

  Future<List<ProductTableData>> getAllProducts() => _database.productTable.all().get();

  Future<ProductTableData?> getProductById(int id) =>
      (_database.select(_database.productTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> createProduct({required String name, required AmountType amountType}) {
    return _database
        .into(_database.productTable)
        .insert(ProductTableCompanion.insert(name: name, amountType: amountType));
  }

  Future<bool> updateProduct({required int id, required String name, required AmountType amountType}) async {
    final updatedRows = await (_database.update(
      _database.productTable,
    )..where((t) => t.id.equals(id))).write(ProductTableCompanion(name: Value(name), amountType: Value(amountType)));

    return updatedRows > 0;
  }

  Future<bool> deleteProduct(int id) async {
    final deletedRows = await (_database.delete(_database.productTable)..where((t) => t.id.equals(id))).go();
    return deletedRows > 0;
  }
}
