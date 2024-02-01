class Product {
  final String uuid;
  final String name;

  const Product({required this.uuid, required this.name});

  factory Product.fromJson({required Map<String, dynamic> json}) {
    return Product(uuid: json['uuid'], name: json['name']);
  }
}
