import 'package:shopengo/models/product.dart';

class ShoppingList {
  final String uuid;
  final List<Product> products;
  final String name;

  const ShoppingList({required this.uuid, required this.products, required this.name});

  ShoppingList.create({required this.uuid, required this.name}) : products = <Product>[];

  factory ShoppingList.fromJson({required Map<String, dynamic> json}) {
    final productJsons = json['products'];

    final products = <Product>[];
    for (final json in productJsons) {
      products.add(Product.fromJson(json: json));
    }

    return ShoppingList(uuid: json['uuid'], products: products, name: json['name']);
  }
}
