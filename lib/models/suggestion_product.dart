import 'package:shopengo/models/product.dart';

class SuggestionProduct extends Product {
  final int purchasedCount;

  const SuggestionProduct({
    required this.purchasedCount,
    required String uuid,
    required String name,
  }) : super(uuid: uuid, name: name);

  SuggestionProduct productPurchased() {
    return SuggestionProduct(purchasedCount: purchasedCount + 1, uuid: uuid, name: name);
  }
}
