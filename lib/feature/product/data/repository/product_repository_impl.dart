import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/data/mapper/product_mapper.dart';
import 'package:shopengo/feature/product/data/repository/product_repository.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/domain/model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  new(this._productDatasource, this._productMapper);

  final ProductDatasource _productDatasource;
  final ProductMapper _productMapper;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final productData = await _productDatasource.getAllProducts();
    return _productMapper.toDomainList(productData);
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    final productData = await _productDatasource.getProductById(id);
    return productData == null ? null : _productMapper.toDomain(productData);
  }

  @override
  Future<int> createProduct({required String name, required AmountType amountType, int? categoryId}) {
    return _productDatasource.createProduct(name: name, amountType: amountType, categoryId: categoryId);
  }

  @override
  Future<bool> updateProduct(ProductModel product) {
    return _productDatasource.updateProduct(
      id: product.id,
      name: product.name,
      amountType: product.amountType,
      categoryId: product.categoryId,
    );
  }

  @override
  Future<bool> deleteProduct(int id) => _productDatasource.deleteProduct(id);
}
