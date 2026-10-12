import 'package:basketwise/feature/category/domain/model/category_model.dart';
import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/product/domain/model/product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel {
  new({
    required this.id,
    required this.name,
    required this.amountType,
    this.categoryId = CategoryModel.defaultCategoryId,
  });

  final int id;

  final String name;

  final AmountType amountType;

  final int categoryId;
}
