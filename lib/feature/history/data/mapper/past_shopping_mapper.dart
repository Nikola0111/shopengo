import 'package:shopengo/feature/history/data/datasource/history_datasource.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_item_model.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_model.dart';

class PastShoppingMapper {
  const new();

  PastShoppingModel toDomain(PastShoppingData data) {
    return PastShoppingModel(
      id: data.shopping.id,
      date: data.shopping.date,
      amountSpent: data.shopping.amountSpent,
      items: [
        for (final item in data.items)
          PastShoppingItemModel(productName: item.productName, amountType: item.amountType, quantity: item.quantity),
      ],
    );
  }

  List<PastShoppingModel> toDomainList(List<PastShoppingData> data) => data.map(toDomain).toList();
}
