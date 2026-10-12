import 'package:basketwise/feature/product/domain/model/amount_type.dart';
import 'package:basketwise/feature/product/domain/model/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel?> getProductById(int id);
  Future<int> createProduct({required String name, required AmountType amountType, int? categoryId});
  Future<bool> updateProduct(ProductModel product);
  Future<bool> deleteProduct(int id);
}
