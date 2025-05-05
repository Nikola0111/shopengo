import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/cubit/home_event.dart';
import 'package:shopengo/feature/home/domain/cubit/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._storeRepository) : super(const HomeState.loading(stores: [])) {
    _setupEventListeners();
  }

  final StoreRepository _storeRepository;

  void _setupEventListeners() {
    on<LoadStoresEvent>((event, emit) async {
      final stores = await _storeRepository.getAllStores();
      emit(HomeState.storesReady(stores: stores));
    });

    on<HomeCreatingStoreEvent>((event, emit) async {
      final currState = state;
      if (currState is HomeStoresReadyState) {
        emit(HomeState.creatingStore(stores: currState.stores));
      }
    });

    on<HomeSubmitNewStoreEvent>((event, emit) async {
      await _storeRepository.createStore(event.storeName);
      add(LoadStoresEvent());
    });

    on<HomeQueryStoresEvent>((event, emit) async {
      final q = event.query;
      final stores = await _storeRepository.searchByQuery(q ?? '');
      emit(HomeState.searchingStores(stores: stores));
    });
  }
}
