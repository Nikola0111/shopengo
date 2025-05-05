import 'package:shopengo/feature/shopping_list/domain/model/shopping_item_model.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_list_model.dart';

abstract class ShoppingListRepository {
  Future<void> createShoppingItem(String name);
  Future<ShoppingListModel> getShoppingItemsByStoreID(int storeID);
  Future<List<ShoppingItemModel>> getRandomShoppingItems();
}
