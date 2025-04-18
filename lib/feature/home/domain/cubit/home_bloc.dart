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
  }

  final StoreRepository _storeRepository;
}
