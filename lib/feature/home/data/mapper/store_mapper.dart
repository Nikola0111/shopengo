import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

class StoreMapper {
  const new();

  StoreModel toDomain(StoreTableData data) {
    return StoreModel(
      id: data.id,
      storeName: data.storeName,
      currency: data.currency,
      previousShoppingAmountSpent: data.previousShoppingAmountSpent,
      previousShoppingArticlesBought: data.previousShoppingArticlesBought,
      previousShoppingDate: data.previousShoppingDate,
      isShopping: data.isShopping,
    );
  }

  List<StoreModel> toDomainList(List<StoreTableData> data) => data.map(toDomain).toList();
}
