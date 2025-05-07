import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/presentation/utils/logger_mixin.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/shopping_list/data/repository/shopping_list_repository.dart';
import 'package:shopengo/feature/shopping_list/domain/cubit/shopping_list_event.dart';
import 'package:shopengo/feature/shopping_list/domain/cubit/shopping_list_state.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_list_model.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> with LoggerMixin {
  ShoppingListBloc(this._storeRepository, this._shoppingListRepository, this.storeID)
      : super(
          ShoppingListState.loading(
            shoppingItems: [],
            selectedStore: StoreModel(id: storeID, storeName: ''),
            shoppingList: ShoppingListModel(storeID: storeID, shoppingItems: []),
          ),
        ) {
    _init();
  }

  final int storeID;
  final StoreRepository _storeRepository;
  final ShoppingListRepository _shoppingListRepository;

  void _init() {
    on<LoadShoppingData>((event, emit) async {
      await _fetchInitialData(emit);
    });

    on<CreateAndAddShoppingItem>((event, emit) async {
      await _createAddShoppingItem(emit, shoppingItemName: event.groceryName);
    });

    on<AddToShoppingList>((event, emit) async {
      await _addItemToShoppingList(event.id);
    });

    on<RemoveFromShoppingList>((event, emit) async {
      await _removeItemFromShoppingList(event.id);
    });
  }

  Future<void> _fetchInitialData(Emitter<ShoppingListState> emit) async {
    try {
      final list = await _shoppingListRepository.getShoppingItemsByStoreID(storeID);
      final items = await _shoppingListRepository.getRandomShoppingItems(list.shoppingItems);
      final store = await _storeRepository.getStoreByID(storeID);

      emit(
        ShoppingListState.ready(
          selectedStore: store,
          shoppingItems: items,
          shoppingList: list,
        ),
      );
    } on Exception catch (e) {
      logE('error fetching initial data: $e');
    }
  }

  Future<void> _createAddShoppingItem(Emitter<ShoppingListState> emit, {required String shoppingItemName}) async {
    emit(
      ShoppingListLoadingState(
        selectedStore: state.selectedStore,
        shoppingItems: state.shoppingItems,
        shoppingList: state.shoppingList,
      ),
    );
    try {
      final shoppingItemID = await _shoppingListRepository.createShoppingItem(shoppingItemName);
      await _shoppingListRepository.addShoppingItemToShoppingList(storeID: storeID, shoppingItemID: shoppingItemID);

      add(const LoadShoppingData());
    } on Exception catch (e) {
      logE('error fetching initial data: $e');
    }
  }

  Future<void> _addItemToShoppingList(int id) async {
    try {
      await _shoppingListRepository.addToShoppingList(shoppingItemID: id, storeID: storeID);
      add(const LoadShoppingData());
    } on Exception catch (e) {
      logE('error fetching initial data: $e');
    }
  }

  Future<void> _removeItemFromShoppingList(int id) async {
    try {
      await _shoppingListRepository.removeFromShoppingList(shoppingItemID: id, storeID: storeID);
      add(const LoadShoppingData());
    } on Exception catch (e) {
      logE('error fetching initial data: $e');
    }
  }

  @override
  String get className => 'ShoppingListCubit';
}
