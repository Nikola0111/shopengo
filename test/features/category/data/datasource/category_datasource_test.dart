import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/category/data/datasource/category_datasource.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

void main() {
  late AppDatabase database;
  late CategoryDatasource datasource;
  late ProductDatasource productDatasource;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = CategoryDatasource(database);
    productDatasource = ProductDatasource(database);
  });

  tearDown(() => database.close());

  test('the default category is seeded', () async {
    final categories = await datasource.getAllCategories();

    expect(categories, hasLength(1));
    final (category, productCount) = categories.single;
    expect(category.id, CategoryModel.defaultCategoryId);
    expect(category.title, CategoryModel.defaultCategoryTitle);
    expect(productCount, 0);
  });

  test('creating a category', () async {
    final id = await datasource.createCategory(title: 'Za bebu', color: 0xFF52B086);
    final categories = await datasource.getAllCategories();

    final (category, productCount) = categories.first;
    expect(category.id, id);
    expect(category.title, 'Za bebu');
    expect(category.color, 0xFF52B086);
    expect(productCount, 0);
  });

  test('lists the default category last', () async {
    final babyId = await datasource.createCategory(title: 'Za bebu', color: 0xFF52B086);
    final petsId = await datasource.createCategory(title: 'Ljubimci', color: 0xFF4EA4DF);

    final ids = [for (final (category, _) in await datasource.getAllCategories()) category.id];

    expect(ids, [babyId, petsId, CategoryModel.defaultCategoryId]);
  });

  test('counts the products in each category', () async {
    final babyId = await datasource.createCategory(title: 'Za bebu', color: 0xFF52B086);
    await productDatasource.createProduct(name: 'Mleko', amountType: AmountType.liter);
    await productDatasource.createProduct(name: 'Pelene', amountType: AmountType.pack, categoryId: babyId);
    await productDatasource.createProduct(name: 'Kašica', amountType: AmountType.piece, categoryId: babyId);

    final counts = {for (final (category, count) in await datasource.getAllCategories()) category.id: count};

    expect(counts, {CategoryModel.defaultCategoryId: 1, babyId: 2});
  });

  test('deleting a category moves its products to the default one', () async {
    final babyId = await datasource.createCategory(title: 'Za bebu', color: 0xFF52B086);
    final productId = await productDatasource.createProduct(
      name: 'Pelene',
      amountType: AmountType.pack,
      categoryId: babyId,
    );

    await datasource.deleteCategory(babyId);
    final product = await productDatasource.getProductById(productId);

    expect(product?.categoryId, CategoryModel.defaultCategoryId);
  });

  test('updating a category', () async {
    final id = await datasource.createCategory(title: 'Za bebu', color: 0xFF52B086);

    await datasource.updateCategory(id: id, title: 'Beba', color: 0xFF4EA4DF);
    final (category, _) = (await datasource.getAllCategories()).first;

    expect(category.title, 'Beba');
    expect(category.color, 0xFF4EA4DF);
  });
}
