import 'dart:ui';

import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:basketwise/feature/category/domain/model/category_model.dart';

class CategoryMapper {
  const new();

  CategoryModel toDomain(CategoryTableData data, {required int productCount}) {
    return CategoryModel(id: data.id, title: data.title, color: Color(data.color), productCount: productCount);
  }

  List<CategoryModel> toDomainList(List<(CategoryTableData, int)> data) {
    return data.map((e) => toDomain(e.$1, productCount: e.$2)).toList();
  }
}
