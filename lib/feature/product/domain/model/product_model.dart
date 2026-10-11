import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

part '../../../../generated/feature/product/domain/model/product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel {
  new({required this.id, required this.name, required this.amountType});

  final int id;

  final String name;

  final AmountType amountType;
}
