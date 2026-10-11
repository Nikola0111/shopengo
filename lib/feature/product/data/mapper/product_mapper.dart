import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

class ProductMapper {
  const new();

  ProductModel toDomain(ProductTableData data) {
    return ProductModel(id: data.id, name: data.name, amountType: data.amountType);
  }

  List<ProductModel> toDomainList(List<ProductTableData> data) => data.map(toDomain).toList();
}
