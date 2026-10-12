import 'dart:ui';

import 'package:basketwise/feature/category/domain/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<int> createCategory({required String title, required Color color});
  Future<bool> updateCategory({required int id, required String title, required Color color});
  Future<bool> deleteCategory(int id);
}
