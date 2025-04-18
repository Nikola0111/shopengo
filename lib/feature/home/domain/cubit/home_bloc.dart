import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/cubit/home_event.dart';
import 'package:shopengo/feature/home/domain/cubit/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._storeRepository) : super(HomeLoadingState()) {
    on<LoadStoresEvent>((event, emit) async {
      final stores = await _storeRepository.getAllStores();
      emit(HomeStoresReadyState(stores: stores));
    });

    on<HomeCreatingStoreEvent>((event, emit) async {
      final currState = state;
      if (currState is HomeStoresReadyState) {
        emit(HomeCreatingStoreState(stores: currState.stores));
      }
    });

    on<HomeSubmitNewStoreEvent>((event, emit) async {
      await _storeRepository.createStore(event.storeName);
      add(LoadStoresEvent());
    });
  }

  final StoreRepository _storeRepository;
}
