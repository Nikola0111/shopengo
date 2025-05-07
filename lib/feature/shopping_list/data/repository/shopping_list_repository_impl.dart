import 'package:shopengo/feature/shopping_list/data/datasource/shopping_list_datasource.dart';
import 'package:shopengo/feature/shopping_list/data/repository/shopping_list_repository.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_item_model.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_list_model.dart';

class ShoppingListRepositoryImpl extends ShoppingListRepository {
  ShoppingListRepositoryImpl(this._datasource);

  final ShoppingListDatasource _datasource;

  @override
  Future<int> createShoppingItem(String name) async {
    final id = await _datasource.createShoppingItem(name);
    return id;
  }

  @override
  Future<ShoppingListModel> getShoppingItemsByStoreID(int storeID) async {
    final shoppingItems = await _datasource.getShoppingListByStoreID(storeID);
    final models = shoppingItems.map((e) => ShoppingItemModel(id: e.id, name: e.name)).toList();
    return ShoppingListModel(storeID: storeID, shoppingItems: models);
  }

  @override
  Future<List<ShoppingItemModel>> getRandomShoppingItems() async {
    final shoppingItems = await _datasource.getRandomShoppingItems();
    final models = shoppingItems.map((e) => ShoppingItemModel(id: e.id, name: e.name)).toList();
    return models;
  }

  @override
  Future<void> addShoppingItemToShoppingList({required int storeID, required int shoppingItemID}) async {
    await _datasource.insertShoppingItemEntry(shoppingItemID: shoppingItemID, storeID: storeID);
  }
}
