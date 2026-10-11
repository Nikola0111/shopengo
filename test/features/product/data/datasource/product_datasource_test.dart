import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

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
    });

    test('updating a product', () async {
      final id = await datasource.createProduct(name: 'Milk', amountType: AmountType.liter);

      final updated = await datasource.updateProduct(id: id, name: 'Flour', amountType: AmountType.kilogram);
      final product = await datasource.getProductById(id);

      expect(updated, isTrue);
      expect(product?.name, 'Flour');
      expect(product?.amountType, AmountType.kilogram);
    });

    test('updating a missing product returns false', () async {
      final updated = await datasource.updateProduct(id: 42, name: 'Flour', amountType: AmountType.gram);
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
