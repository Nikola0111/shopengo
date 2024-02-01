import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/mixins/logger_mixin.dart';
import 'package:shopengo/core/services/router_service.dart';
import 'package:shopengo/features/shopping_lists/bloc/shopping_lists_event.dart';
import 'package:shopengo/features/shopping_lists/bloc/shopping_lists_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListsEvent, ShoppingListsState> with LoggerMixin {
  final _routerService = KiwiContainer().resolve<RouterService>();

  ShoppingListBloc() : super(const ViewingShoppingLists(shoppingLists: [])) {
    on<InitialEvent>((event, emit) {
      logI('initial event');
      // read from service
      emit(const ViewingShoppingLists(shoppingLists: []));
    });

    on<CreatingNewList>((event, emit) {
      logI('creating new list event');
      // _routerService.router.push(SingleProduct);
    });

    on<QueryShoppingLists>((event, emit) {
      logI('querying shopping lists with query string: ${event.queryString}');
      final queriedItems = event.queriedList.where((element) => false).toList();
      emit(ViewingShoppingLists(shoppingLists: event.queriedList, queriedList: queriedItems));
    });

    on<OpenShoppingList>((event, emit) {
      logI('opening shopping list with id: ${event.shoppingListID}');
      // _routerService.router.push(SingleProduct);
    });

    on<StartShopping>((event, emit) {
      logI('starting shopping with id: ${event.shoppingListID}');
      // _routerService.router.push(StartShoppingPage);
    });

    on<ViewListHistory>((event, emit) {
      logI('opening list history with id: ${event.shoppingListID}');
      // _routerService.router.push(SingleProduct); - view history tab
    });
  }

  @override
  String get className => 'BottomNavigationBloc';
}
