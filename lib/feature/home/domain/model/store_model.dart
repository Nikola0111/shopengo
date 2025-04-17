import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/feature/home/domain/model/store_model.freezed.dart';

@freezed
class StoreModel with _$StoreModel {
  StoreModel({required this.productCode});

  @override
  final String productCode;
}
