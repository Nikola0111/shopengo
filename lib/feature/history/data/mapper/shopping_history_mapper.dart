import 'package:shopengo/feature/history/data/datasource/history_datasource.dart';
import 'package:shopengo/feature/history/domain/model/shopping_history_item_model.dart';
import 'package:shopengo/feature/history/domain/model/shopping_history_model.dart';

class ShoppingHistoryMapper {
  const new();

  ShoppingHistoryModel toDomain(ShoppingHistoryData data) {
    return ShoppingHistoryModel(
      id: data.shopping.id,
      date: data.shopping.date,
      amountSpent: data.shopping.amountSpent,
      items: [
        for (final item in data.items)
          ShoppingHistoryItemModel(productName: item.productName, amountType: item.amountType, quantity: item.quantity),
      ],
    );
  }

  List<ShoppingHistoryModel> toDomainList(List<ShoppingHistoryData> data) => data.map(toDomain).toList();
}
