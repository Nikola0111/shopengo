import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/category/domain/model/category_model.freezed.dart';

@freezed
class CategoryModel with _$CategoryModel {
  new({required this.id, required this.title, required this.color, this.productCount = 0});

  /// Seeded on database creation. Products without an explicit category belong to it.
  static const int defaultCategoryId = 1;
  static const String defaultCategoryTitle = 'Other';
  static const int defaultCategoryColor = 0xFF9A96B5;

  final int id;

  final String title;

  final Color color;

  final int productCount;

  bool get isDefault => id == defaultCategoryId;
}
