import 'dart:ui';

import 'package:shopengo/feature/category/domain/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<int> createCategory({required String title, required Color color});
}
