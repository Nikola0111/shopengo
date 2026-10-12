import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:basketwise/feature/category/domain/model/category_model.dart';
import 'package:basketwise/feature/product/data/datasource/product_datasource.dart';
import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductDatasource datasource;
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = ProductDatasource(database);
  });

  tearDown(() => database.close());

  group('basic crud operations', () {
    test('return list should be empty', () async {
      final products = await datasource.getAllProducts();
      expect(products, isEmpty);
    });

    test('creating a product', () async {
      final id = await datasource.createProduct(name: 'Milk', amountType: AmountType.liter);
      final product = await datasource.getProductById(id);

      expect(product?.name, 'Milk');
      expect(product?.amountType, AmountType.liter);
      expect(product?.categoryId, CategoryModel.defaultCategoryId);
    });

    test('updating a product', () async {
      final id = await datasource.createProduct(name: 'Milk', amountType: AmountType.liter);

      final updated = await datasource.updateProduct(
        id: id,
        name: 'Flour',
        amountType: AmountType.kilogram,
        categoryId: CategoryModel.defaultCategoryId,
      );
      final product = await datasource.getProductById(id);

      expect(updated, isTrue);
      expect(product?.name, 'Flour');
      expect(product?.amountType, AmountType.kilogram);
    });

    test('updating a missing product returns false', () async {
      final updated = await datasource.updateProduct(
        id: 42,
        name: 'Flour',
        amountType: AmountType.gram,
        categoryId: CategoryModel.defaultCategoryId,
      );
      expect(updated, isFalse);
    });

    test('deleting a product', () async {
      final id = await datasource.createProduct(name: 'Eggs', amountType: AmountType.piece);

      final deleted = await datasource.deleteProduct(id);
      final products = await datasource.getAllProducts();

      expect(deleted, isTrue);
      expect(products, isEmpty);
    });
  });
}
