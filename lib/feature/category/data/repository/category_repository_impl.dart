import 'dart:ui';

import 'package:shopengo/feature/category/data/datasource/category_datasource.dart';
import 'package:shopengo/feature/category/data/mapper/category_mapper.dart';
import 'package:shopengo/feature/category/data/repository/category_repository.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  new(this._categoryDatasource, this._categoryMapper);

  final CategoryDatasource _categoryDatasource;
  final CategoryMapper _categoryMapper;

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final categoryData = await _categoryDatasource.getAllCategories();
    return _categoryMapper.toDomainList(categoryData);
  }

  @override
  Future<int> createCategory({required String title, required Color color}) {
    return _categoryDatasource.createCategory(title: title, color: color.toARGB32());
  }
}
